From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Need help to install LTTng on Ubunto 10.04
Date: Tue, 04 Sep 2012 03:43:41 -0400
Message-ID: <5045B12D.4010503__295.563767622475$1346744656$gmane$org@voxpopuli.im>
References: <CALJd4cYWZM3DjFRpe2QB4sxpcWzxpSQ_=zRK=RUtCWBgEnKH0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1T8nnc-000549-2j
	for lttng-dev@lists.lttng.org; Tue, 04 Sep 2012 03:43:52 -0400
In-Reply-To: <CALJd4cYWZM3DjFRpe2QB4sxpcWzxpSQ_=zRK=RUtCWBgEnKH0w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ashoka K <ashok.vinu@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 12-09-04 03:18 AM, Ashoka K wrote:
> Hi,
>
> I have tried the below commands to install LTT on  VMware running Ubuntu
> 10.04, but got the following error. Please help.

Hi,

The PPA only offers packages for 11.10 (Oneiric) and 12.04 (Precise).
One of the main reasons being that the LTTng kernel tracer requires at
least Linux 2.6.38. Ubuntu 10.04 comes with 2.6.32 by default.

If you cannot upgrade your distro, you could always install a more
recent kernel (from the package called
"linux-image-generic-lts-backport-oneiric" in the main repo, for
example) and compile/install the tools by hand. The 12.04 packages
probably won't work on 10.04, since the latter didn't have multiarch.


Cheers,

-- =

Alexandre Montplaisir
DORSAL lab,
=C9cole Polytechnique de Montr=E9al
