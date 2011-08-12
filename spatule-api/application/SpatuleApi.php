<?php
/*
 *  Copyright 2011, Remi Patriarche
 *
 *  This file is part of Spatule.
 *
 *  Spatule is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as 
 *	published by the Free Software Foundation, either version 3 of
 *  the License, or (at your option) any later version.
 *
 *  Spatule is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with Spatule.  If not, see <http://www.gnu.org/licenses/>.
 */

use Route\GetAuthRoute;
use Model\Constants;
use Model\User\User;
use Service\Security\ApiSecurityServiceImpl;
use Service\Imputation\ImputationServiceImpl;


require_once __DIR__.'/../vendor/Silex/silex.phar';

$app = new Silex\Application();

$app['debug'] = true;

$app['autoloader']->registerNamespaces(array(
    'Common'  => __DIR__,  
    'Route'   => __DIR__,    
    'Model'   => __DIR__,
    'Service' => __DIR__
));

// registers doctrine extension
$app->register(new Silex\Extension\DoctrineExtension(), array(
    'db.options' => array(
        'driver'   => 'pdo_mysql',
        'dbname'   => 'spatuledb',
        'host'     => 'localhost',
        'user'     => 'root',
        'password' => ''
    ),
    //'db.dbal.class_path'   => __DIR__.'/../vendor/doctrine-dbal/lib',
    //'db.common.class_path' => __DIR__.'/../vendor/doctrine-common/lib',
    'db.dbal.class_path'   => __DIR__.'/../vendor',
    'db.common.class_path' => __DIR__.'/../vendor'
));

//$app->register(new Constants());

$app->register(new ApiSecurityServiceImpl());
$app->register(new ImputationServiceImpl());

// configure routes through beans
$app->register(new GetAuthRoute());

/*
// GET auth/ return the user code from credentials
$app->get('/auth/{mail}/{password}', function ($mail, $password) use ($app) {
//  $sql = "SELECT user_id FROM user WHERE mail=? AND password=?";
//    $res = $app['db']->fetchAssoc($sql, array($app->escape($mail), $app->escape($password)));
    
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
*/

return $app;

?>