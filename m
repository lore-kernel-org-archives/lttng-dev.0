From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?DEFINE=5FEVENT=5FMAP=5FNOARGS_missing_DEFIN?=
	=?utf-8?q?E=5FTRACE?=
Date: Fri, 28 Mar 2014 12:07:43 +0800
Message-ID: <6b6a30d0-5e3c-4c2c-9b76-a9b33925ea8e__6626.41049498252$1395979740$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-320.freemail.mail.aliyun.com ([110.75.46.20])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1WTO5B-0004FI-Ae
 for lttng-dev@lists.lttng.org; Fri, 28 Mar 2014 00:08:01 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,dev

   Sorry for not testing by hand ,but I noticed that there is no #define DEFINE_EVENT_MAP_NOARGS() DEFINE_TRACE() in probes/define_trace.h.So is it a missing ?(I have to admit that I am strucky by all these macros ,so if I am wrong,please point it out. )

PS: lttng-moudles version 2.3.0

Thanks
zhenyu.ren
