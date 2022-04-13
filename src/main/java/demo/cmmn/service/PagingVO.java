package demo.cmmn.service;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class PagingVO {

	private int currPageNo;
	private int prevPageNo;
	private int nextPageNo;
	private int totalRecord;
	private int blockStartPageNo;
	private int blockEndPageNo;
	
	public PagingVO() {}
	public PagingVO(int totalRecord, int currPageNo) {
		this.totalRecord = totalRecord;
		this.currPageNo = currPageNo;
		
		this.init();
	}
	private void init() {
		if (this.totalRecord > 0 && this.currPageNo > 0) {			
			int currBlockNo = (int) Math.ceil((double)this.currPageNo/(double)CmmnConst.BLOCK_COUNT_PER_PAGE);
			int lastPageNo = (int) Math.ceil((double)this.totalRecord/(double)CmmnConst.RECORD_COUNT_PER_PAGE);
			
			this.blockStartPageNo = currBlockNo * CmmnConst.BLOCK_COUNT_PER_PAGE - CmmnConst.BLOCK_COUNT_PER_PAGE + 1;
			this.blockEndPageNo = currBlockNo * CmmnConst.BLOCK_COUNT_PER_PAGE;
			this.blockEndPageNo = lastPageNo <= this.blockEndPageNo ? lastPageNo : this.blockEndPageNo;
			this.prevPageNo = (this.blockStartPageNo - 1 > 0 ? this.blockStartPageNo - 1 : 0);
			this.nextPageNo = (this.blockEndPageNo + 1 < lastPageNo ? this.blockEndPageNo + 1 : 0);
		}
	}
	public int getFirstIndex() {
		return this.currPageNo * CmmnConst.RECORD_COUNT_PER_PAGE - CmmnConst.RECORD_COUNT_PER_PAGE + 1;
	}
	public int getRecordCountPerPage() {
		return CmmnConst.RECORD_COUNT_PER_PAGE;
	}
	public int getCurrPageNo() {
		return currPageNo;
	}
	public void setCurrPageNo(int currPageNo) {
		this.currPageNo = currPageNo;
		this.init();
	}
	public int getPrevPageNo() {
		return prevPageNo;
	}
	public void setPrevPageNo(int prevPageNo) {
		this.prevPageNo = prevPageNo;
	}
	public int getNextPageNo() {
		return nextPageNo;
	}
	public void setNextPageNo(int nextPageNo) {
		this.nextPageNo = nextPageNo;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		this.init(); 
	}
	public int getBlockStartPageNo() {
		return blockStartPageNo;
	}
	public void setBlockStartPageNo(int blockStartPageNo) {
		this.blockStartPageNo = blockStartPageNo;
	}
	public int getBlockEndPageNo() {
		return blockEndPageNo;
	}
	public void setBlockEndPageNo(int blockEndPageNo) {
		this.blockEndPageNo = blockEndPageNo;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
	
}
