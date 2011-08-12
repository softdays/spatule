<?php

namespace Service\Imputation;

use Silex\ExtensionInterface;

interface ImputationService extends ExtensionInterface {
	
	/**
	 * Try to retrieve the user id from given mail and password.
	 * @param $mail The user mail as login.
	 * @param $password The user password (SHA1 encrypted).
	 */
	public function loadUserId($mail, $password);
	
}

?>