From: Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
Subject: Re: Question about Transformation to CTF file
Date: Thu, 09 Aug 2012 10:43:15 -0400
Message-ID: <5023CC83.9070107__24440.0854608559$1344523456$gmane$org@polymtl.ca>
References: <BLU157-W4856E0646C86D62AD6C1D1D6CE0@phx.gbl>
	<BLU157-W15D8B7E7F51D2008B7A46CD6CC0@phx.gbl>
	<20120809131314.GA8081@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexandre.montplaisir@polymtl.ca>)
	id 1SzTxl-0002ub-FI
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 10:43:49 -0400
In-Reply-To: <20120809131314.GA8081@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Runhua Xu <xurunhua23@hotmail.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthew Khouzam <m.khouzam@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Hi,

On 12-08-09 09:13 AM, Mathieu Desnoyers wrote:
> CCing lttng-dev and eclipse lttng plugin developers,
>
> * Runhua Xu (xurunhua23@hotmail.com) wrote:
> [...]
>> way, but I couldn't find more information about that). However, when I
>> use the Eclipse Linux Tools to open the CTF file, it reports error
>> "Problems occurred when invoking code from plug-in:
>> "org.eclipse.jface". I tried the tools with the sample CTF file, which
>> is provided by LTTng, it succeeded. Then I looked into the metadata of
>> the transferred CTF file (see below codes in blue), it seems that it
>> remains the original format, doesn't change based on my input file.
> This looks like a bug in the eclipse tool. I'll let Alexandre handle
> this part. Please test with "babeltrace" too to see if it is parsed
> correctly by the C parser.

Could we get a copy of that trace please? If the CTF is invalid, then of
course it might have problems parsing, but it could be interesting to
see if the error handling is done correctly.


To convert traces to and from CTF format, you might want to check out
the not-yet-officially-released Javeltrace tool:
http://www.dorsal.polymtl.ca/~pproulx/javeltrace/

It won't do what you want to do out of the box, but it really helps
understanding the CTF format.

Cheers,

-- =

Alexandre Montplaisir
DORSAL lab,
=C9cole Polytechnique de Montr=E9al
