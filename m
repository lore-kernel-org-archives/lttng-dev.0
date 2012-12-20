From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: LTTng 2.1: create session errors
Date: Thu, 20 Dec 2012 13:52:15 -0500
Message-ID: <50D35E5F.6020405__1850.13326486132$1356029615$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr3.ericy.com ([198.24.6.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TllEl-0001q9-CD
	for lttng-dev@lists.lttng.org; Thu, 20 Dec 2012 13:52:55 -0500
Received: from EUSAAHC002.ericsson.se ([147.117.188.78])
	by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id qBKIqmqd024627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2012 12:52:48 -0600
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

Hello

I'm currently using lttng-tools 2.1.0-RC9. I see some errors when using 
"lttng create " with streaming options:

1) lttng create mysession -C net://192:1.1.1: -D net://192:1.1.1.1

The command output shows:
    Session mysession created.
    Traces will be written in (null)
    Control URL net://192.1.1.1.1 set for session mysession
    Data URL net://192.1.1.1.1 set for session mysession

The line "Traces will be written in (null)" should show the correct 
location similar when using the -U option. Also, when typing "lttng list 
mysession" afterwards the trace path is not displayed correctly. 
(mysession (net://192.1.1.1:5342/ [data: 5343]) [inactive]).

2) lttng create mysession -C net://192:1.1.1:5342 -D net://192.1.1.1:5343

This command output shows:
    Session mysession created.
    Traces will be written in (null)
    Error: Control URL uses the net:// protocol and the data URL is 
different. Not allowed.
    Error: Invalid parameter

The command fails with an error. However, the session seems to be 
created, but no consumer is defined. First of all, it should be possible 
to define the port with the option -C and -D. Secondly, if an error 
occurs the session shouldn't be created.

3) lttng create mysession -C net://192.1.1.1

This command doesn't fail. I expected it to fail since the command help 
states that -D <data URL> must be used too. BTW, "lttng create mysession 
-D net://192.1.1.1" fails.

4) lttng create mysession -C net://192:1.1.1 -D net://192.1.1.2
This command fails, because the IP address is not the same. Is this 
intended?

5) In "lttng create -h" and "enable-consumer -h" show "tcp[4|6]" as 
possible protocols, but "tcp4" doesn't work. I have to use "tcp". The 
help should be updated for that.

6) Why isn't it possible to use "tcp[6]" together with option -U? 
Instead "net[6]" has to be used, which defaults to TCP as network transport.

Could someone please look into this?

Best Regards
Bernd



-- 
This Communication is Confidential. We only send and receive email on 
the basis of the terms set out at www.ericsson.com/email_disclaimer
