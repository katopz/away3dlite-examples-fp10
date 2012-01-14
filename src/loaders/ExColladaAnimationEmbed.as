package loaders
{
	import away3dlite.animators.BonesAnimator;
	import away3dlite.core.base.Object3D;
	import away3dlite.core.utils.*;
	import away3dlite.events.Loader3DEvent;
	import away3dlite.loaders.*;
	import away3dlite.materials.*;
	import away3dlite.primitives.*;
	import away3dlite.templates.BasicTemplate;

	import flash.display.*;
	import flash.geom.Vector3D;
	import flash.utils.*;

	[SWF(backgroundColor = "#000000", frameRate = "30", width = "800", height = "600")]

	/**
	 * Collada Animation example.
	 */
	public class ExColladaAnimationEmbed extends BasicTemplate
	{
		private var _collada:Collada;
		private var _bonesAnimator:BonesAnimator;

		[Embed(source = "assets/dae/nemuvine/nemuvine.dae", mimeType = "application/octet-stream")]
		private var _modelClazz:Class;

		[Embed(source = "assets/dae/nemuvine/body.png")]
		private const clazz_0:Class;

		[Embed(source = "assets/dae/nemuvine/book_blue.png")]
		private const clazz_1:Class;

		[Embed(source = "assets/dae/nemuvine/chair.png")]
		private const clazz_2:Class;

		[Embed(source = "assets/dae/nemuvine/cloth.png")]
		private const clazz_3:Class;

		[Embed(source = "assets/dae/nemuvine/face2.png")]
		private const clazz_4:Class;

		[Embed(source = "assets/dae/nemuvine/table.png")]
		private const clazz_5:Class;

		private function onSuccess(event:Loader3DEvent):void
		{
			var _model:Object3D = event.target["handle"];
			_model.canvas = event.target["canvas"];
			//_model.canvas.visible = false;

			_bonesAnimator = _model.animationLibrary.getAnimation("default").animation as BonesAnimator;
		}

		override protected function onInit():void
		{
			title += " : Collada Example.";
			Debug.active = true;
			camera.y = -500;
			camera.lookAt(new Vector3D());

			_collada = new Collada();
			_collada.scaling = 25;
			Loader3D.images["body.png"] = clazz_0;
			Loader3D.images["book_blue.png"] = clazz_1;
			Loader3D.images["chair.png"] = clazz_2;
			Loader3D.images["cloth.png"] = clazz_3;
			Loader3D.images["face2.png"] = clazz_4;
			Loader3D.images["table.png"] = clazz_5;

			var _loader3D:Loader3D = new Loader3D();
			scene.addChild(_loader3D);
			var dae:String = new _modelClazz();
			var xml:XML = new XML(dae);
			_loader3D.parseXML(xml, _collada);
			//_loader3D.loadGeometry("../assets/dae/nemuvine/nemuvine.dae", _collada);
			_loader3D.addEventListener(Loader3DEvent.LOAD_SUCCESS, onSuccess);

			_loader3D.canvas = new Sprite();
			view.addChild(_loader3D.canvas);
		}

		override protected function onPreRender():void
		{
			//update the collada animation
			if (_bonesAnimator)
				_bonesAnimator.update(getTimer() / 1000);

			scene.rotationY++;
		}
	}
}
