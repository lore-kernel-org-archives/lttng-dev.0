From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: Missing tracepoint entries when listing fields in LTTng
	Tools 2.1
Date: Fri, 14 Sep 2012 08:24:10 -0400
Message-ID: <505321EA.1060007__29558.2831874073$1347625490$gmane$org@ericsson.com>
References: <5050CD26.6020707@ericsson.com> <20120912191400.GA31291@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TCUwZ-0000L9-Ht
	for lttng-dev@lists.lttng.org; Fri, 14 Sep 2012 08:24:23 -0400
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q8ECShcH015752
	for <lttng-dev@lists.lttng.org>; Fri, 14 Sep 2012 07:28:44 -0500
In-Reply-To: <20120912191400.GA31291@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi

I executed command "lttng list -u -f" (in LTTng Tools 2.1 RC2) to list 
all the available UST tracers and their tracepoints/fields. I noticed 
that some tracepoints are not listed when they don't have any fields. I 
think this is not  correct because the "-f" option should just give more 
detailed information, but should not remove information.

To re-produce, use the hello.cxx test application delivered with LTTng UST.
"lttng list -u" shows:
PID: 6056 - Name: /home/bernd/git/lttng-ust/tests/hello.cxx/.libs/lt-hello
       ust_tests_hello:tptest_sighandler (loglevel: TRACE_DEBUG_LINE 
(13)) (type: tracepoint)
       ust_tests_hello:tptest (loglevel: TRACE_DEBUG_LINE (13)) (type: 
tracepoint)

"lttng list -u -f shows:
PID: 6056 - Name: /home/bernd/git/lttng-ust/tests/hello.cxx/.libs/lt-hello
       ust_tests_hello:tptest (loglevel: TRACE_DEBUG_LINE (13)) (type: 
tracepoint)
         field: doublefield (float)
         field: floatfield (float)
         field: stringfield (string)
         field: seqfield2 (string)
         field: seqfield1 (unknown)
         field: arrfield2 (string)
         field: arrfield1 (unknown)
         field: netintfieldhex (integer)
         field: netintfield (integer)
         field: longfield (integer)
         field: intfield2 (integer)
         field: intfield (integer)

Best Regards
Bernd


-- 
This Communication is Confidential. We only send and receive email on 
the basis of the terms set out at www.ericsson.com/email_disclaimer
