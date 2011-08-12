<?php
namespace Common;

use Silex\Application;
use Silex\ExtensionInterface;

abstract class AbstractExtension implements ExtensionInterface {
	
    public function register( Application $app ) {
        $app[get_class($this)] = $this;
    }
	
	public static function getClassName() {
        
        return get_called_class();
    }
}