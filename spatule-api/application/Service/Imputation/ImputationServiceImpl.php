<?php
namespace Service\Imputation;

use Silex\Application;
use Service\Imputation\ImputationService;


class ImputationServiceImpl implements ImputationService {
	
    private $db_wrapper;
	
    public function register( Application $app ) {
        $this->db_wrapper = $app['db'];
        $app['imputation_svc'] = $this;
//        $app['imputation_svc'] = $app->share(function ($imput_svc) {
//		    return $imput_svc;
//		});
    }
    
	
	public function loadUserId( $mail, $password ) {
		$sql = "SELECT user_id FROM user WHERE mail=? AND password=?";
		
        return $this->db_wrapper->fetchAssoc( $sql, array( $mail, $password ));
	}
}
?>