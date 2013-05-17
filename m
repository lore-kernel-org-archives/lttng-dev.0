From: Yang Wang <yangw.wang5@unb.ca>
Subject: Re: Mariadb+LTTng 2.x
Date: Fri, 17 May 2013 21:21:10 +0000
Message-ID: <8E0A14A4C9B95B459AE214584119C1EB417EFCEC__15026.4631877237$1368826018$gmane$org@tulip.ad.unb.ca>
References: <8E0A14A4C9B95B459AE214584119C1EB417EDCD7@tulip.ad.unb.ca>,
	<20130517184604.GA2020@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from cadence.its.unb.ca ([131.202.1.23])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yangw.wang5@unb.ca>) id 1UdS5V-0006z7-2E
	for lttng-dev@lists.lttng.org; Fri, 17 May 2013 17:21:17 -0400
In-Reply-To: <20130517184604.GA2020@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Graeme Johnson <Graeme_Johnson@ca.ibm.com>, Kenneth Kent <ken@unb.ca>, Yannick Brosseau <yannick.brosseau@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

It seems not this compatibility problem. I have removed all ust1.0 stuffs in the instrumented Mariadb code and
replaced with lttng-ust 2.x say, tracepoint statements, trancepoint provider files, probes files and use the lib -llttng-ust instead of -lust. Anything I missed?


Is "libust[7848/7853]: " reported from lttng-tools 2.0? Actually, this is printed from

lttng-ust-2.1.2

Thanks

Yang
________________________________________
From: Mathieu Desnoyers [mathieu.desnoyers@efficios.com]
Sent: Friday, May 17, 2013 3:46 PM
To: Yang Wang
Cc: Yannick Brosseau; David Goulet; Alexandre Montplaisir; Graeme Johnson; Kenneth Kent; lttng-dev@lists.lttng.org
Subject: Re: Mariadb+LTTng 2.x

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
