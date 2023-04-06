Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29156C7618D
	for <lttng-dev@archiver.kernel.org>; Thu,  6 Apr 2023 20:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1680812088;
	bh=Lw06925XhiDg7BfB2YxIjWDfbw5ZghIs7HrSD6K30P0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=FVGSJYcfT1ZZEJ/5QetNEOMxKXdee491kn0yU16hw9tMbg7HDe+owMujgq8mBk9cl
	 YheUY5QViFLWXeJLneC8j35uL92g+yLB3993snIUdAmkZcYhWmLfTZDjmCXfGy0t/c
	 tnRDZE/Eg3i2StYa858T2l6QutdzLMX5M2IhiTmQPGz5PwY1q1X/gLfQLbkT+uAyw1
	 iBrcS/VZGxfKqy5YfFFNsRnpIhmhFcb2lPqqug9R8DfD0MeSRT1amORG8nru8qndne
	 NaApiOTAweEj0lwu98Gz41a8s7VwiNcQr7Shxd9CKi2EbOusGtBOQSO7PyE/fDGI6e
	 Mcf2ajouVpQkQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pst5M2QNMz2NQ5;
	Thu,  6 Apr 2023 16:14:47 -0400 (EDT)
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pssjv1b2Gz2NKL
 for <lttng-dev@lists.lttng.org>; Thu,  6 Apr 2023 15:57:55 -0400 (EDT)
Received: from horde2019.polymtl.ca (www.imp.polymtl.ca [132.207.6.45])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 336JuVEd021794
 for <lttng-dev@lists.lttng.org>; Thu, 6 Apr 2023 15:56:31 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 336JuVEd021794
Received: from Sansfil-Eduroam-Etudiants-15-40.polymtl.ca
 (Sansfil-Eduroam-Etudiants-15-40.polymtl.ca [10.200.15.40]) by
 www.imp.polymtl.ca (Horde Framework) with HTTPS; Thu, 06 Apr 2023 19:56:30
 +0000
Date: Thu, 06 Apr 2023 19:56:30 +0000
Message-ID: <20230406195630.Horde.jhBZfsMqxFud8S3napU7CjJ@www.imp.polymtl.ca>
To: lttng-dev@lists.lttng.org
User-Agent: Horde Application Framework 5
MIME-Version: 1.0
Content-Disposition: inline
X-Poly-FromMTA: (www.imp.polymtl.ca [132.207.6.45]) at Thu,
 6 Apr 2023 19:56:31 +0000
X-Mailman-Approved-At: Thu, 06 Apr 2023 16:14:45 -0400
Subject: [lttng-dev] Seeking Assistance on LTTng for Kubernetes Performance
 Research
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Benjamin Saint-Cyr via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Benjamin Saint-Cyr <benjamin.saint-cyr@polymtl.ca>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Dear LTTng Developers,

I am currently conducting performance research on Kubernetes for my  
master's thesis and am using LTTng for data collection and Trace  
Compass for analysis. I have a couple of questions and concerns, and I  
would appreciate your guidance to ensure I am using your tools  
effectively.

	1. In the Control Flow view, I can see the CPU throttling due to the  
quota defined in the Cgroup as the pod runs and then waits for the CPU  
periodically. However, it is unclear whether the pod is waiting due to  
a full CPU or because of timeshares. I can easily find this  
information in /sys/fs/cgroup/cpu,cpuacct/kubepods/<burstable or  
besteffort>/pod<UID>/cpu.stat if the pod is being throttled. Is there  
a way to extract this information using LTTng or Trace Compass?

	2. I am attempting to determine which PID is running a specific  
Container/Pod UID. Currently, I can deduce this by observing the  
process named runc[*:INIT], as it creates the cgroup and clones the  
process for the container. However, this approach is fragile and only  
works due to an implementation detail. It also fails if tracing starts  
after deployment. This information is easily available in  
/sys/fs/cgroup/cpu,cpuacct/kubepods/<burstable or  
besteffort>/pod<UID>/<container ID>/cgroup.procs. Is there an existing  
method within LTTng to obtain this information that I may not be aware  
of?

I have been informed that it might be possible to read the information  
in cpu.stat or cgroup.procs using a state dump at the beginning or  
end, but the process remains unclear. Alternatively, I could  
instrument the kernel or the process handling the accounting, but this  
would be quite challenging. Another option would be to use something  
similar to cAdvisor, but its efficiency is questionable since it  
dedicates an entire process to reading a few files.

I would greatly appreciate any guidance or suggestions you may have on  
improving my approach and effectively utilizing LTTng for my research.

Thank you for your time and assistance.

Best regards,

Benjamin Saint-Cyr




_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
