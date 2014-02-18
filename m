From: Santiago Font <sfont@teldat.com>
Subject: LTTng-ust 2.4.0-rc4 build error with uClibc
Date: Tue, 18 Feb 2014 16:56:42 +0100
Message-ID: <530382BA.2060301__14127.9222713367$1392740436$gmane$org@teldat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.teldat.com ([195.53.62.69])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sfont@teldat.com>) id 1WFn2R-00066d-TV
	for lttng-dev@lists.lttng.org; Tue, 18 Feb 2014 10:56:57 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I'm trying to build LTTng-ust using uClibc and I get the following error:

                         ustdl.c:95:22: error: 'RTLD_DI_LINKMAP' 
undeclared (first use in this function)

Checking the file dlfcn.h from uClibc, the code defining that enum is 
disabled by:

                         #if 0 /* not supported by uClibc */

How can I fix this?

Thanks,
               Santi
