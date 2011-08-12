<?php
namespace Service\Security;

use Silex\ExtensionInterface;

interface ApiSecurityService extends ExtensionInterface {
	
	/**
	 * 
	 * Enter description here ...
	 * @param Integer $user_id The user id.
	 * @param String $mail The user mail.
	 * @param String $password The user password (SHA1 encrypted);
	 */
	public function getApiKey( $user_id, $mail, $password );
	
}
