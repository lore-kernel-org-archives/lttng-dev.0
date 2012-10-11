From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: TMF current and future developments
Date: Thu, 11 Oct 2012 13:14:37 -0400
Message-ID: <5076FE7D.4050207__1626.63857122443$1349975744$gmane$org@voxpopuli.im>
References: <20121010160629.dcsyijhgooowckoo@mail.encs.concordia.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1TMMLl-00016o-1G
	for lttng-dev@lists.lttng.org; Thu, 11 Oct 2012 13:15:09 -0400
In-Reply-To: <20121010160629.dcsyijhgooowckoo@mail.encs.concordia.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Efraim Josue Lopez Sanchez <e_lopezs@encs.concordia.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Efraim,

On 12-10-10 04:06 PM, Efraim Josue Lopez Sanchez wrote:
> Hi,
>
> We are planning to build on top of TMF. Most recently we have tried
> implementing some stuffs so that we can familiarize with TMF source
> code. However, I've been wondering these last days about the future
> plans/developments related to TMF. Is there any webpage/place/document
> where I can find information regarding what are you guys
> working/developing right now? And also about the future
> developments/versions?

If you want to track the very latest development, you can look at the
patches that are going in for review on Gerrit, at
https://git.eclipse.org/r/#/q/status:open+project:linuxtools/org.eclipse.li=
nuxtools,n,z
(not everything is related to TMF/LTTng, but it should be obvious what
is by looking at the modified files).

Most of it is targeted at the "lttng-kepler" branch on git, which should
ultimately be part of the 2.0 release next June. If you want to try/test
the latest code, you should use that branch.

There is also a small list of planned features on
http://eclipse.org/linuxtools/projectPages/lttng/ under "Future Plans".

If you have any question about specific features, let us know!


Cheers,

-- =

Alexandre Montplaisir
DORSAL lab,
=C9cole Polytechnique de Montr=E9al
