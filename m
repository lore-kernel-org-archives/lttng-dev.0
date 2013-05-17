From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Mariadb+LTTng 2.x
Date: Fri, 17 May 2013 14:46:04 -0400
Message-ID: <20130517184604.GA2020__13726.0359748781$1368816406$gmane$org@Krystal>
References: <8E0A14A4C9B95B459AE214584119C1EB417EDCD7@tulip.ad.unb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UdPfL-0005ku-9J
	for lttng-dev@lists.lttng.org; Fri, 17 May 2013 14:46:07 -0400
Content-Disposition: inline
In-Reply-To: <8E0A14A4C9B95B459AE214584119C1EB417EDCD7@tulip.ad.unb.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yang Wang <yangw.wang5@unb.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Graeme Johnson <Graeme_Johnson@ca.ibm.com>, Kenneth Kent <ken@unb.ca>, Yannick Brosseau <yannick.brosseau@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

lttng-ust 2.1 is not compatible with lttng-tools 2.0.

2.1 with 2.1, 2.0 with 2.0.

Thanks,

Mathieu

* Yang Wang (yangw.wang5@unb.ca) wrote:
> I have ported Mariadb+UST1.0 to Mariadb+LTTng 2.0. 
> but when I initialize system tables 
> 
> scripts/mysql_install_db --basedir=/usr/local/mysql --user=mysql
> 
> It reports
> 
> libust[7848/7853]: Error: incorrect message size: 292
>  (in ustcomm_recv_app_reply() at lttng-ust-comm.c:523)
> libust[7848/7853]: Error: incorrect message size: 292
>  (in ustcomm_recv_app_reply() at lttng-ust-comm.c:523)
> libust[7848/7853]: Error: incorrect message size: 292
>  (in ustcomm_recv_app_reply() at lttng-ust-comm.c:523)
> 130517 13:12:20 [Note] /usr/local/mysql/libexec/mysqld: Shutdown complete
> 
> 
> I am using lttng-ust-2.1.2
> 
> Could anyone help me figure out the reason?
> 
> Thanks
> 
> Yang
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
