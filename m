From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: dlopen, gcc -l and LD_PRELOAD
Date: Wed, 20 Mar 2013 16:00:40 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD028AB5__14610.3232553743$1363796157$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UILfH-0001lZ-SX
	for lttng-dev@lists.lttng.org; Wed, 20 Mar 2013 12:14:59 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

> Message: 1
> Date: Tue, 19 Mar 2013 11:51:29 -0400
>
> >> I don't see this warning and error here. Which release are you using?
>>
> >    lttng-modules 2.1.1+ (74b9312, 2013-02-27)
> >    lttng-tools 2.1.1+ (e58727c, 2013-03-01)
> >    lttng-ust 2.1.1+ (009769c, 2013-03-05)
> >    userspace-rcu 0.7.6+ (108a92e, 2013-02-22)
> >
>
> I can confirm I'm able to reproduce the problem with these versions.
>
> >    (All are moderately dated by now, but none of the later commit =

> > comments seem pertinent)
>
> This revision fixed the "undefined symbol: tracepoint_dlopen" problem:
> https://bugs.lttng.org/projects/lttng-ust/repository/revisions/558b9d8624=
7004f8e9bbaf8c982f3b2b182093d1

   Doh!  It had to be the revision right after the one I was using.

   Meanwhile I've been playing with some very simple examples of .so use, a=
nd found that the behaviour of LD_PRELOAD is incompletely documented.  For =
instance, if I run:

LD_LIBRARY_PATH=3D. ./sometest

   Where sometest is a simple application which uses a libwhatever.so built=
 in the same directory, it works.  But:

LD_PRELOAD=3D./libwhatever.so ./sometest

   Fails with "No such file or directory".  LD_PRELOAD and LD_LIBRARY_PATH =
are NOT interchangeable.  The nitty-gritty (thanks to LD_DEBUG=3Dlibs) is a=
s follows (my apologies if this is old-hat to fellow lttngeeks, but it was =
certainly new to me):

   Upon launching a process, the dynamic loader searches for the executable=
's requested libraries in the following ordered list of places, stopping as=
 soon as a match is found:

. the rpath directory (or colon-separated directories) encoded in the execu=
table, if any, but only if runpath is not also set (e.g. gcc -Wl,-rpath,'$O=
RIGIN/rpath' etc.) (instead of using the linker -rpath option, you can set =
LD_RUN_PATH before calling the linker);
. the (colon-separated) directories listed in the environment variable LD_L=
IBRARY_PATH, if any;
. the runpath directory (or colon-separated directories) encoded in the exe=
cutable, if any (e.g. gcc -Wl,-rpath,'$ORIGIN/rpath',--enable-new-dtags etc=
.; although it is possible to modify the binary so rpath and runpath are di=
fferent, gcc sets both values to the same string);
. the directories listed or included in /etc/ld.so.conf, if any;
. the trusted directory /lib; and finally
. the trusted directory /usr/lib.

   If the executable was linked with the -z nodeflib option ("no def lib"),=
 then ld.so will not look in the last three locations for the requested sha=
red library (that is to say, the search stops with the third bullet above).=
  The Linux /etc/ld.so.conf typically uses an explicit include instruction =
to add the collection of .conf files in the /etc/ld.so.conf.d directory.  T=
he /etc/ld.so.conf.d files themselves are sorted alphabetically.  (I skip o=
ver /etc/ld.so.cache and the important role of the ldconfig command).  The =
found library is initialised, and then the dynamic loader checks in the fol=
lowing locations for the requested library:

. the libraries (not directories) listed in the environment variable LD_PRE=
LOAD, if any (absolute or relative paths; LD_PRELOAD accepts colon- and/or =
space-separated entries); and
. the libraries (not directories) listed in the system file /etc/ld.so.prel=
oad, if any.

  If LD_PRELOAD or /etc/ld.so.preload supply a replacement library, the lat=
ter is initialised and its members pre-empt those from the previously found=
 library.  Preloading thus serves to substitute replacements for some of th=
e "normal" library methods.  Because full dynamicity (i.e. using dlopen to =
fetch the library) does not involve the dynamic loader, preloading does *no=
t* work against it.  Also, if the requested library is not found in the "no=
rmal" places (rpath, LD_LIBRARY_PATH, runpath, /etc/ld.so.conf, /lib, /usr/=
lib) the dynamic loader issues an error ("cannot open shared object file: N=
o such file or directory") and does *not* look into LD_PRELOAD and /etc/ld.=
so.preload.

   There are additional subtleties involving set-user-ID/set-group-ID binar=
ies, but this is otherwise as complete as I can make it.

   The above should explain the trouble I've been having with lttng-ust's d=
oc/examples/easy-ust and tests/demo.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
