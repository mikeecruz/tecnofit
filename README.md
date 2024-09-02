# TECNOFIT 

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
