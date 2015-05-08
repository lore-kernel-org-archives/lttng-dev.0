From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?can_we_do_live_local_tracing_without_relay_?=
	=?utf-8?q?daemon=3F?=
Date: Fri, 08 May 2015 10:56:35 +0800
Message-ID: <44b3df76-3fac-4311-96b7-160a2d488f24__37063.6538057171$1431053913$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-113.freemail.mail.aliyun.com ([115.124.18.13])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1YqYTg-0002cf-Rk
 for lttng-dev@lists.lttng.org; Thu, 07 May 2015 22:57:33 -0400
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

   From https://lttng.org/docs/#doc-lttng-live,it seems that relay daemon is necessary for live tracing. I wondered whether I can do live LOCAL tracing without relay daemon,say implemented it on consumer daemon side rather than relay daemon side, to avoid one more memory copy for the performance sake.

Thanks
zhenyu.ren
