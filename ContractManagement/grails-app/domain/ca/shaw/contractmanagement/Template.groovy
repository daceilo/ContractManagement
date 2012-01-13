package ca.shaw.contractmanagement

class Template {
	private static final int TEN_MEG_IN_BYTES = 1024*1024*10
	byte[] data
	String fileName
	String description
	int size
	
    static constraints = {
		data( nullable: false, minSize: 1, maxSize: TEN_MEG_IN_BYTES )
		fileName( nullable: false, blank: false )
		description( nullable: false, blank: false )
		size( nullable: false )		
    }
}
