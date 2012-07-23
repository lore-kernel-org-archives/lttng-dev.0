From: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Subject: Re: When is tracepoint registration finished?
Date: Mon, 23 Jul 2012 06:58:08 +0000
Message-ID: <524C960C5DFC794E82BE548D825F05CF5BC5D30F__4959.75964372537$1343026737$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <524C960C5DFC794E82BE548D825F05CF56CB1DF1@EU-MBX-04.mgc.mentorg.com>
	<20120720182101.GD20073@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Fredrik_Oestman@mentor.com>) id 1StCax-0001Po-EC
	for lttng-dev@lists.lttng.org; Mon, 23 Jul 2012 02:58:19 -0400
In-Reply-To: <20120720182101.GD20073@Krystal>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Mathieu Desnoyers wrote:
> Oestman, Fredrik (Fredrik_Oestman@mentor.com) wrote:
> > Is there any way to know from within the instrumented application
> > when tracepoint registration is finished?
> =

> No.

OK. Does any internal knowledge about this exist somewhere, which could be =
externalized?


> > On ARM, this messes up LTTng UST and faulty events are recorded.
> What do you mean by faulty events ?

1. Wrong trace data type:
1.a) A tracepoint for one type produces events of another type, for which t=
here is a tracepoint.
1.b) A tracepoint produces a non-existing type, which makes babeltrace chok=
e on the data, index out of range
2. Wrong field: Data belonging to field #2 sent in field #1, in combination=
 with 1.a)


> Well, if you trace _all_ function calls, then you get all function
> calls

Yes, this was no surprise, just one more reason to try to find out when tra=
cepoint registration is finished.


Cheers,

Fredrik =D6stman
