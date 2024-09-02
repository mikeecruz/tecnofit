<?php

/*
    Author: Michael Cruz
    Date: 2021-03-01
    Description: Retorna o ranking de um movimento específico
    Parameters:
        - movement_id: ID do movimento
    Return:
        - status: true ou false
        - response: array com o ranking
            - movement: nome do movimento
            - ranking: array com os usuários e seus rankings
                - position: posição no ranking
                - name: nome do usuário
                - record: o seu ranking
                - record_date: data da sua melhor pontuação
                - record_date_formated: data da sua melhor pontuação formatada
    Example:
        - http://localhost/tecnofit/index.php?movement_id=1
    Tech:
        - PHP 8.2.12
        - MySQL
*/

header('Content-Type: application/json');

/** Configurações do banco de dados **/
$host = '*';
$dbname = '**';
$username = '***';
$password = '****';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Verifica se o parâmetro de entrada é válido
    if(!isset($_GET['movement_id']) || !intval($_GET['movement_id'])){
        http_response_code(500);
        echo json_encode(
            [
                'status' => false,
                'response' => 'Parâmetro inválido'
            ]
        );
        exit;
    }
    $movement_id = intval($_GET['movement_id']);

    $sql = "
        SELECT m.name AS movement_name,
            u.name AS user_name,
            MAX(pr.value) AS personal_record,
            MAX(pr.date) AS record_date
        FROM personal_record pr
        INNER JOIN user u ON pr.user_id = u.id
        INNER JOIN movement m ON pr.movement_id = m.id
        WHERE pr.movement_id = :movement_id
        GROUP BY pr.user_id
        ORDER BY personal_record DESC, user_name ASC, record_date ASC;
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute(['movement_id' => $movement_id]);
    $result = $stmt->fetchAll(PDO::FETCH_OBJ);

    // Se não houver resultado, retorna uma mensagem de erro
    if (empty($result)) {
        http_response_code(200);
        echo json_encode(
            [
                'status' => false,
                'response' => 'Nenhum resultado encontrado'
            ]
        );
        exit;
    }

    $count = $current = 0;
    $previous = null;
    $ranked_users = [];
    foreach ($result as $key => $row) {
        if ($previous !== null && $row->personal_record == $previous) {
            $count++;
        } else {
            $current += $count + 1;
            $count = 0;
        }
        $previous = $row->personal_record;
        $ranked_users[] = [
            'position' => $current,
            'name' => $row->user_name,
            'record' => $row->personal_record,
            'record_date' => $row->record_date,
            'record_date_formated' => date('d/m/Y', strtotime($row->record_date))
        ];
    }

    $response = [
        'status' => true,
        'response' => [
            'movement' => current($result)->movement_name,
            'ranking' => $ranked_users
        ]
    ];
    http_response_code(200);
    echo json_encode($response);
    exit;
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(
        [
            'status' => false,
            'response' => $e->getMessage()
        ]
    );
    exit;
}

