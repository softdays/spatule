<?php
namespace Service\Security;

use Model\Constants;
use Silex\Application;
use Service\Security\ApiSecurityService;

class ApiSecurityServiceImpl implements ApiSecurityService {
	
    public function register( Application $app ) {
        $app['security_svc'] = $this;
    }
	
	public function getApiKey( $user_id, $mail, $password ) {
		
		return sha1($user_id . $mail . Constants::API_KEY_SECRET . $password);
	}
	
	
}