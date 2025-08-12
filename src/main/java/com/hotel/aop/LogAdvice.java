package com.hotel.aop;

import lombok.extern.log4j.Log4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

@Aspect
@Component
@Log4j
public class LogAdvice {

    @Pointcut("execution(* com.hotel.controller..*(..))")
    public void controllerLayer(){}

    @Around("controllerLayer()")
    public Object logHttp(ProceedingJoinPoint pjp) throws Throwable {
        long start = System.currentTimeMillis();

        ServletRequestAttributes at = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest req = (at != null) ? at.getRequest() : null;

        String http = (req != null) ? req.getMethod() : "-";
        String uri  = (req != null) ? req.getRequestURI() : "-";
        String qs   = (req != null && req.getQueryString()!=null) ? "?"+req.getQueryString() : "";
        String user = "anonymous";
        var a = SecurityContextHolder.getContext().getAuthentication();
        if (a != null && a.isAuthenticated() && !"anonymousUser".equals(a.getName())) user = a.getName();

        Signature sig = pjp.getSignature();
        String cls = sig.getDeclaringType().getSimpleName();
        String mtd = sig.getName();

        try {
            Object ret = pjp.proceed();
            long took = System.currentTimeMillis() - start;

            int status = 200;
            if (ret instanceof ResponseEntity) {
                status = ((ResponseEntity<?>) ret).getStatusCodeValue();
            } else if (at != null && at.getResponse() != null) {
                status = at.getResponse().getStatus();
            }

            log.info(String.format("[HTTP] user=%s %s %s%s -> %d %s.%s() (%d ms)",
                    user, http, uri, qs, status, cls, mtd, took));
            return ret;
        } catch (Throwable ex) {
            long took = System.currentTimeMillis() - start;
            log.error(String.format("[HTTP] user=%s %s %s%s -> ERROR %s.%s() (%d ms) %s",
                    user, http, uri, qs, cls, mtd, took, ex.getClass().getSimpleName()), ex);
            throw ex;
        }
    }
}
