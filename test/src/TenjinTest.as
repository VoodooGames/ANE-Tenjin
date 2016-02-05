package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;
	
	import io.voodoo.tenjin.Tenjin;
	
	
	/**
	 * 
	 */
	public class TenjinTest extends Sprite {
		
		// PARAMS :
		private static const TOKEN:String = "E3OTCZ3UQ1OUEWUD3W9SO8JT6REPCZ5U";
		
		
		// PROPERTIES :
		private var dy:Number;
		
		// CONSTRUCTOR
		public function TenjinTest() {
			super();
			
			dy = 30;
			
			addButton("Init", initTenjin);
			addButton("Send Event", sendEvent);
			addButton("Send Event With Value", sendEventWithValue);
			addButton("Transaction", transaction);
		}
		
		private function initTenjin():void {
			trace("Init");
			Tenjin.init(TOKEN);
		}
		
		private function sendEvent():void {
			trace("Send event");
			Tenjin.sendEvent("TestEvent");
		}
		
		private function sendEventWithValue():void {
			trace("Send event with value");
			Tenjin.sendEventWithValue("TestEventWithValue", new Date().time);
		}
		
		private function transaction():void {
			trace("Transaction");
			Tenjin.transaction("MyProduct", "USD", 10, 2.5);
		}
		
		
		
		private function addButton(label:String, onClick:Function):void {
			var b:Sprite = new Sprite();
			b.graphics.beginFill(0xbbbbbb);
			b.graphics.lineStyle(1, 0x222222, 1, true);
			b.graphics.drawRect(0, 0, stage.stageWidth - 20, 40);
			b.graphics.endFill();
			b.x = 10;
			b.y = dy;
			dy += 70;
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("Arial", 14, 0, true, null, null, null, null, TextFormatAlign.CENTER);
			tf.text = label;
			tf.x = 10;
			tf.y = 10;
			tf.selectable = false;
			tf.width = stage.stageWidth - 40;
			tf.height = 20;
			b.addChild(tf);
			
			b.addEventListener(MouseEvent.CLICK, function(ev:MouseEvent):void { onClick(); });
			
			addChild(b);
		}
	}
}