package com.xinbo.spider.executor.handle;

import com.xinbo.spider.executor.service.ExecutorService;
import com.xxl.job.core.biz.model.ReturnT;
import com.xxl.job.core.handler.annotation.XxlJob;
import com.xxl.job.core.log.XxlJobLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ShellHandle {

    @Autowired
    private ExecutorService executorService;

    @XxlJob("hg_ver")
    public ReturnT<String> hgVer(String param) {
        try {
            XxlJobLogger.log("--------------- hg_ver: starting... ---------------------");
            List<String> result = executorService.runShell(param);
            result.forEach(XxlJobLogger::log);
            XxlJobLogger.log("--------------- hg_ver: ending... ---------------------");
            return ReturnT.SUCCESS;
        } catch (Exception ex) {
            XxlJobLogger.log(ex);
            return ReturnT.FAIL;
        }
    }

    @XxlJob("hg_check_user")
    public ReturnT<String> hgCheckUser(String param) {
        try {
            XxlJobLogger.log("--------------- hg_check_user: starting... ---------------------");
            List<String> result = executorService.runShell(param);
            result.forEach(XxlJobLogger::log);
            XxlJobLogger.log("--------------- hg_check_user: ending... ---------------------");
            return ReturnT.SUCCESS;
        } catch (Exception ex) {
            XxlJobLogger.log(ex);
            return ReturnT.FAIL;
        }
    }


}
