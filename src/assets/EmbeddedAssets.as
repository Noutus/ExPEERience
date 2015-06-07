package src.assets
{
	public class EmbeddedAssets
	{
		[Embed(source="../../assets/action_popup.png")]
		public static const actionPopups:Class;
		[Embed(source="../../data/atlas.xml", mimeType="application/octet-stream")]
		public static const actionPopupsXML:Class;
		
		[Embed(source="../../assets/walk.png")]
		public static const walkAnim:Class;
		[Embed(source="../../data/walk.xml", mimeType="application/octet-stream")]
		public static const walkAnimXML:Class;
	}
}