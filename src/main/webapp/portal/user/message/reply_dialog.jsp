<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
			                    		<!-- modal -->
										<div class="modal fade" id="myModa_information_02${index.count }" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
											<!-- modal-dialog --> 
											<div class="modal-dialog">
											<!-- modal-content开始 -->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
														<h4 class="modal-title">众投客</h4>
													</div>
													<div class="modal-body">
														<p>${message.content }</p>
													    <form id="reply_message">
													    	<textarea style="width:97%; margin:10px 0px; height:70px;" id="message_${index.count }_con" onblur="clear_focus('message_${index.count }_con')" onclick="clear_focus('message_${index.count }_con')"></textarea>
													    	<input type="button" class="btn-ju-bdr" style="width: 200px; font-size: 18px; height: 34px; margin-left: 180px;cursor: pointer;" onclick="reply_sure('${index.count }','${message.fromId }','${message.fromName }')" value="确认回复"/>	
													    </form>
													</div>
												</div>
												<!-- modal-content --> 
											</div>
											<!-- modal-dialog --> 
										</div>
										<!-- modal -->