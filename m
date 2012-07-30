From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Module lttng_tracer not found.
Date: Mon, 30 Jul 2012 10:16:23 -0400
Message-ID: <50169737.5010805__44176.6513199129$1343657836$gmane$org@voxpopuli.im>
References: <CABy43G956NYAU4MG9p32+17jwJt8-6TZsdP9xysNs63CGw0hbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1SvqmB-0003bE-Eb
	for lttng-dev@lists.lttng.org; Mon, 30 Jul 2012 10:16:51 -0400
In-Reply-To: <CABy43G956NYAU4MG9p32+17jwJt8-6TZsdP9xysNs63CGw0hbg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rui Han <r.han@umiami.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

What steps did you use to install LTTng?

Also can you please paste the output of:
$ apt-cache policy lttng-modules-dkms


Thanks,

-- =

Alexandre Montplaisir
DORSAL lab,
=C9cole Polytechnique de Montr=E9al



On 12-07-29 04:26 PM, Rui Han wrote:
> Hi,
>
> I used lttng last week and didn't touch it ever since. I am trying to use
> it again. I use lttng list -k, it give me error messages:
>
> FATAL: Module lttng_tracer not found.
> Error: Unable to load module lttng-tracer
> Error: Unable to remove module lttng-tracer
> Warning: No kernel tracer available
> Error: Unable to list kernel events
>
> I run kernel tracing as root. At first, I thought I have to start the
> daemon by lttng-sessiond command. It gave me the error: "Error: Already
> running daemon." At this time, I can create session, it gave "Session
> session created. Traces will be written in
> /root/lttng-traces/session-20120729-160806". However, it failed to genera=
te
> a single term of tracing. While I tried lsmod, there are no lttng related
> module in the list. Which I remember there were several. The same thing
> happened to my two ubuntu systems. I restarted the system, it still doesn=
't
> work. Does any one know how to make lttng work again in this situation?
>
> Thank you very much.
>
> Best regards,
> Rui
