From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: Questions about trace streaming
Date: Wed, 18 Sep 2013 13:36:12 -0400
Message-ID: <5239E48C.8080708__29123.0968120091$1379525838$gmane$org@efficios.com>
References: <15791CE1D0394DEA8AEEC1E9AAD00832@DVDMANDT5>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VMLfo-0000DA-2L
	for lttng-dev@lists.lttng.org; Wed, 18 Sep 2013 13:36:25 -0400
In-Reply-To: <15791CE1D0394DEA8AEEC1E9AAD00832@DVDMANDT5>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?David_Lindstr=F6m?= <david.lindstrom@percepio.se>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

On 13-09-18 11:39 AM, David Lindstr=F6m wrote:
> Hi, I have some quick questions about trace streaming, that is over TCP.
> =

> 1. What is the overall status of trace streaming?
Are you talking about trace streaming (sending traces from the trace
consumer to a remote host), or live trace reading (reading the trace
while it is being recorded) ?

For trace streaming, this feature is working since LTTng 2.1 and you can
refer to doc/streaming-howto.txt to get started.

For the live trace reading, I just submitted all my code base to David
for review and progressive merge into master, we intend to have a RC1
around mid-november.

> 2. How can I get started?
If you want to try the live trace reading, I can send you my branches on
github, but I would recommend you wait until the first review is done.

> 3. Is the protocol(s) documented and reasonably stable? If so, where can
> I find information about said protocol(s)?
Right now the streaming and live-reading protocols are not documented. I
am starting the live-reading protocol documentation right now, I'll send
it here when it is done.

Thanks,

Julien
