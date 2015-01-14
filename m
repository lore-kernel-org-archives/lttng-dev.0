From: Charles Briere <c.briere@samsung.com>
Subject: UST tracing problem on ARM/Android
Date: Wed, 14 Jan 2015 22:17:56 +0000
Message-ID: <1421273876.3881.68.camel__16131.6042453565$1421273936$gmane$org@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]
 helo=usmailout1.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1YBWGL-0003WS-71
 for lttng-dev@lists.lttng.org; Wed, 14 Jan 2015 17:18:09 -0500
Received: from uscpsbgex1.samsung.com
 (u122.gpu85.samsung.co.kr [203.254.195.122]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NI600HFOTXYUY60@mailout1.w2.samsung.com> for
 lttng-dev@lists.lttng.org; Wed, 14 Jan 2015 17:17:58 -0500 (EST)
Received: from sisasmtp.sisa.samsung.com ([105.144.21.115])
 by usmmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-27.01(7.0.4.27.0) 64bit (built Aug
 30 2012)) with ESMTP id <0NI6004DATXYJH30@usmmp2.samsung.com> for
 lttng-dev@lists.lttng.org; Wed, 14 Jan 2015 17:17:58 -0500 (EST)
Content-language: en-US
Content-id: <6DF0F6BE6AEB874DA7AFC10C823383A9@samsung.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello world,

I've been running in some inssues lately with UST on ARM/Android. Using
the following to configure my session, I enable every ust event.

lttng create
lttng enable-event -ua

Although, when a tracepoint is called, its state ( struct
lttng_ust_tracepoint -> state) is 0. 

My understanding of the whole registration process is limited, so the
following reasoning is probably flawed, so please correct me if that
happens. 

I found out, that when registering the library
(tracepoint_register_lib), callsite_table is populated. But later on
when it comes to register the probes (lttng_prove_register),
callsite_table 's address is different and the list is empty. As a
result, when tracepoint_sync_callsite() is called, set_tracepoint() is
never executed as looping through an empty list. 

What I don't understand in here, is that the callsite_table pointer is
not the same during the lib registration and probe registration. Both
are ran sequentially in the same thread and I can't figure what other
operation could affect the variable. Any hint/help would be much
appreciated.

Thanks,
Charles
