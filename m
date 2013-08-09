From: Stanislav Vovk <stanislav.vovk@ericsson.com>
Subject: one sessiond for multiuser system
Date: Fri, 9 Aug 2013 08:01:07 +0000
Message-ID: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A223B68__47364.6069680855$1376035329$gmane$org@ESESSMB105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailgw7.ericsson.se ([193.180.251.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stanislav.vovk@ericsson.com>) id 1V7hdG-0004rd-Op
	for lttng-dev@lists.lttng.org; Fri, 09 Aug 2013 04:01:15 -0400
Content-Language: en-US
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

Hi,

Have a few questions regarding lttng configuration in a multi user system.

In my system there are two users, root and Bob. I am starting sessiond at boot as root user. And instrumented programs are started as either root or Bob. I am logged in to the system and controlling lttng as root user.

- When executing "lttng list -u" I see events registered by programs started as root. I don't see events from programs started as Bob. Why? Did I forget something?

- Now I switch user to Bob in the shell. Executing "lttng list -u" does not give any output at all, instead a new sessiond is started. How can I have one sessiond for the whole system?

Cheers,
Stanislav
