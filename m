From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Viewing userspace apps traces
Date: Tue, 02 Oct 2012 16:29:24 -0400
Message-ID: <506B4EA4.8050407__25657.1126672954$1349209813$gmane$org@voxpopuli.im>
References: <506B4A21.6080309@fnac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1TJ95u-0005LE-DS
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 16:29:30 -0400
In-Reply-To: <506B4A21.6080309@fnac.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Chavent <paul.chavent@fnac.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Paul,

On 12-10-02 04:10 PM, Paul Chavent wrote:
> Hi.
>
> Today, I've tested the tracing of a user space app.
>
> I wonder what is the best solution for viewing it ?
>
> I have tried babeltrace that produce a good comprehensive text outpout.
> I have tried eclipse that isn't able to use the vtid and vpid context.
> It's unfortunate as i would like to see a timeline representation...

Do you mean the Events view does not show the event contexts? It should,
afaik. It could be a bug.

As for graphical views, like timegraphs, it's not easy to have a general
view that can work with any UST trace. Each application defines its own
event types, so we have no guarantee for any given event type to be there.

What would you like see in your "timeline representation" exactly? Maybe
we could give you some pointers as to how to implement such a view.
(We're currently working on making it easy to extend the framework to
implement new views, so this could be a good exercise!)

> Is it a good solution to use the custom text parser of the eclipse tool ?

Not really, the custom parsers are, for example, when you have a text
log and want to import it into the TMF framework. LTTng/UST traces are
in CTF format, and that format is already supported in TMF.



Cheers,

-- =

Alexandre Montplaisir
DORSAL lab,
=C9cole Polytechnique de Montr=E9al
