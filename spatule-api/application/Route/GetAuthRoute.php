<?php
namespace Route;

use Common\AbstractExtension;
use Silex\Application;
use Symfony\Component\HttpFoundation\Response;

/**
 * 
 * GET auth/ return the user code from credentials.
 * @author rpatriarche
 *
 */
class GetAuthRoute extends AbstractExtension {
	
	public function register( Application $app ) {
		parent::register($app);
		 
		$app->get('/auth/{mail}/{password}', function ($mail, $password) use ($app) {

			$escapedMail = $app->escape($mail);
			$escapedPwd = $app->escape($password);

			$user_id = $app['imputation_svc']->loadUserId( $escapedMail, $escapedPwd );

			if (empty($user_id))
			{
				new Response(
				json_encode(array('errors' => array(
                'name'=>'UNKNOWN_USER', 
                'message'=>'wrong login credentials'))), 
				403,
				array('Content-Type' => 'text/json; charset=utf-8'));
			}

			$api_key = $app['security_svc']->getApiKey($user_id, $escapedMail, $escapedPwd);

			return new Response(
			json_encode(array('api-key' => $api_key)),
			200,
			array('Content-Type' => 'text/json; charset=utf-8'));
		});
	}
	
}

?>