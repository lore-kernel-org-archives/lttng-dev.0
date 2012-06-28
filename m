From: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Subject: Support for large files
Date: Thu, 28 Jun 2012 08:12:47 +0000
Message-ID: <524C960C5DFC794E82BE548D825F05CF28348826__17628.4191119068$1340871210$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Fredrik_Oestman@mentor.com>) id 1Sk9qT-0003uO-Lr
	for lttng-dev@lists.lttng.org; Thu, 28 Jun 2012 04:12:57 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1Sk9qN-00079i-3R from Fredrik_Oestman@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 28 Jun 2012 01:12:51 -0700
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

We've run into a problem when attempting to produce large traces on a 32-bi=
t machine. =


This is the console output:

Session met-2012-06-15_16-09-25 created.
Traces will be written in /home/nasir/lttng-traces/met-2012-06-15_16-09-25-=
20120615-160925
UST channel met_tools enabled for session met-2012-06-15_16-09-25
UST event met_func:* created in channel met_tools
UST event met_call:* created in channel met_tools
Tracing started for session met-2012-06-15_16-09-25
Ackermann: Jun 15 2012 16:01:06
Error: Error writing to tracefile
Tracing stopped for session met-2012-06-15_16-09-25
Session met-2012-06-15_16-09-25 destroyed

This is the trace directory (from another, identical run):

-rwxrwxrwx 1 nasir nasir       4096 2012-06-18 18:38 metadata*
-rwxrwxrwx 1 nasir nasir          0 2012-06-18 18:38 met_tools_0*
-rwxrwxrwx 1 nasir nasir          0 2012-06-18 18:38 met_tools_1*
-rwxrwxrwx 1 nasir nasir 2147483647 2012-06-18 18:40 met_tools_2*
-rwxrwxrwx 1 nasir nasir          0 2012-06-18 18:38 met_tools_3*

That the application runs on one core only is expected. The file size is 2 =
GiB - 1, which
is the limit for 32-bit file offset variables.

On 64-bit machines, the problem doesn't occur.

Is this problem known?

We are using lttng-ust 2.0.1 and userspace-rcu 0.6.7.


Cheers,

Fredrik =D6stman
