From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: lttngtop dependencies
Date: Tue, 21 Oct 2014 14:09:34 -0400
Message-ID: <5446A15E.50205__2974.8621899218$1413915045$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD6207057A@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XgdsM-0005DR-W8
 for lttng-dev@lists.lttng.org; Tue, 21 Oct 2014 14:09:48 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD6207057A@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thanks for the feedback.
The include of lttng.h was an old requirement, I removed it.
The include of lttngtop-helper is only necessary when compiling the
highly experimental mmap live feature (that I should probably remove).

So only the lttng runtime binaries are required for the local live
tracing, I updated the README to clarify that.

Thanks,

Julien

On 14-10-21 10:44 AM, Thibault, Daniel wrote:
> Currently, the lttngtop/README mentions only the following dependencies:
> =

> * gcc 3.2 or better
> * libc6 development librairies (Debian : libc6, libc6-dev) (Fedora : glib=
c, glibc)
> * glib 2.22 or better development libraries (Debian : libglib2.0-0, libgl=
ib2.0-dev) (Fedora : glib2, glib2-devel)
> * libpopt >=3D 1.13 development libraries (Debian : libpopt-dev) (Fedora =
: popt)
> * ncurses development libraries (Debian : libncurses5-dev)
> * babeltrace >=3D 1.2.0 development library
> =

>    However, since 19 October 2013 (http://git.lttng.org/?p=3Dlttngtop.git=
;a=3Dcommitdiff;h=3D16b22a0fe150f4923b9902e802bbf28bacce8d0e), lttngtop dep=
ends on lttng-tools (for lttng/lttng.h, lttng/lttngtop-helper.h and later h=
eaders, needed to handle live traces).  This must be added to the README (n=
ot to mention any DEBIAN/control package files).
> =

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Ce=
ntre
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
