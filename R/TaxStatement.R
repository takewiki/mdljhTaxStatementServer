#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' TaxStatementViewServer()
TaxStatementViewServer <- function(input,output,session,dms_token,erp_token) {
  #获取参数
  text_TaxStatement_FYear = tsui::var_text('text_TaxStatement_FYear')

  text_TaxStatement_FMonth = tsui::var_text('text_TaxStatement_FMonth')

  text_TaxStatement_FOrgNumber = tsui::var_text('text_TaxStatement_FOrgNumber')


  #outputDir= getwd()
  outputDir = '/home/srv/shiny-server/mdljhTaxStatementCom'

  original = paste0(outputDir, "/www/TaxStatement/税务报表.xlsx")

  shiny::observeEvent(input$btn_TaxStatement_Generate,{

    if(text_TaxStatement_FYear()=='' ||text_TaxStatement_FMonth()==''|| text_TaxStatement_FOrgNumber() ==''){

      tsui::pop_notice('请填写查询信息')
    }
    else{
      FYear=text_TaxStatement_FYear()
      FMonth=text_TaxStatement_FMonth()
      FOrgNumber = text_TaxStatement_FOrgNumber()
      #删除税务报表
      file.remove(original)

      #生成税务报表
      mdljhTaxStatementPkg::TaxStatement_excel(erpToken = erp_token,FYear =FYear ,FMonth =FMonth,FOrgNumber =FOrgNumber,outputDir = outputDir )


      tsui::pop_notice("报表已生成")

    }




  })

  output$dl_TaxStatement_excel <- downloadHandler(
    filename = "税务报表.xlsx",
    content = function(file) {

      if (file.exists(original)) {
        file.copy(original, file)

      } else {
        tsui::pop_notice("报表未生成,无法下载。")
      }
    }
  )


}




#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' TaxStatementServer()
TaxStatementServer <- function(input,output,session,dms_token,erp_token) {
  TaxStatementViewServer(input = input,output = output,session = session,dms_token = dms_token,erp_token=erp_token)


}
