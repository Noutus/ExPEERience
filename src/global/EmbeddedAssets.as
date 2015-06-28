package src.global {
	
	/**
	 * Contains all embedded assets.
	 */
	public class EmbeddedAssets {
		
		/** Contains the pop-up buttons for the action phase. */
		[Embed(source = "../../assets/action_popup.png")]
		public static const actionPopups: Class;
		
		/** Contains the XML data needed for the pop-up buttons for the action phase. */
		[Embed(source = "../../data/atlas.xml", mimeType = "application/octet-stream")]
		public static const actionPopupsXML: Class;
	}
}