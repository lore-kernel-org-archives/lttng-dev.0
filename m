From: Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
Subject: Re: Fedora distro
Date: Fri, 08 Jun 2012 11:41:06 -0400
Message-ID: <4FD21D12.4020907__16752.0665716895$1339170108$gmane$org@polymtl.ca>
References: <B37BA2DB1EC9984A9CF9143C8BD9B067194FB2B213@RIGEL.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexandre.montplaisir@polymtl.ca>)
	id 1Sd1JJ-0001co-GQ
	for lttng-dev@lists.lttng.org; Fri, 08 Jun 2012 11:41:13 -0400
In-Reply-To: <B37BA2DB1EC9984A9CF9143C8BD9B067194FB2B213@RIGEL.analogic.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Pelletier, Joe" <JPelletier@analogic.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

On 12-06-08 08:46 AM, Pelletier, Joe wrote:
> Hello,
> I'm trying to find a tool chain for testing Fedora distributions and as I=
 read through the LTTng web pages thought I had found exactly what I needed=
. Unfortunately for me only Ubuntu and OpenSuse distributions are available=
. Are there any plans for a Fedora release? If there aren't plans for a Fed=
ora release, does anyone have any suggestions for a trace toolkit for Fedor=
a? This sounds like a great tool!

The OpenSuse builds also build packages for Fedora 15 and 16. If you
follow that link on the download page, on the OBS page you have links to
Fedora repositories on the right.

The lttng-modules package however seems to have failed building, I don't
know if it's temporary or if that one is simply not available on Fedora.
In the meanwhile you might have to compile that part by hand.


Cheers,

-- =

Alexandre Montplaisir
DORSAL lab,
=C9cole Polytechnique de Montr=E9al
