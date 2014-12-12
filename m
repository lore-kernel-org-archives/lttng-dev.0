From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Errors compiling converted tp file
Date: Fri, 12 Dec 2014 14:13:16 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD6FBE3A22__8037.261296022$1418393652$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD6FBE18D6@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <9F3E07F7-AA26-49A3-BE48-E117868890E2@gmail.com>
 <CA+jJMxuf5wHG2MBSh4bFmn=BOi2b=O2vH+THT9mphVZR0_asfw@mail.gmail.com>
 <BE7D65EA-876D-4CB9-A935-659200D5BE77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XzQyG-0000Kk-QG
 for lttng-dev@lists.lttng.org; Fri, 12 Dec 2014 09:13:30 -0500
In-Reply-To: <BE7D65EA-876D-4CB9-A935-659200D5BE77@gmail.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yan Grange <ygrange@gmail.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> Let me start by thanking you for all the support you give (it is impressi=
ngly fast).
> =

> So if I look in the repo, with the ppa installed, I can't find liburcu:
>
> $ cat /etc/apt/sources.list.d/lttng-ppa-precise.list
> deb http://ppa.launchpad.net/lttng/ppa/ubuntu precise main deb-src http:/=
/ppa.launchpad.net/lttng/ppa/ubuntu precise main
>
> (I have asked my admin to do an apt-get update)
>
> $ apt-cache search lttng
> lttng-modules-dkms - Linux Trace Toolkit (LTTng) kernel modules (DKMS) lt=
tng-tools - LTTng control and utility programs
> liblttng-ust0 - LTTng 2.0 Userspace Tracer (libraries) liblttng-ust-dev -=
 LTTng 2.0 Userspace Tracer (development files) liblttng-ctl-dev - LTTng co=
ntrol and utility library (development files)
> liblttng-ctl0 - LTTng control and utility library liblttng-ust-java-jni -=
 LTTng 2.0 Userspace Tracer (JNI interface) liblttng-ust-java - LTTng 2.0 U=
serspace Tracer (Java support library) python-lttng - Python bindings for L=
TTng
> liblttng-ust-ctl2 - LTTng 2.0 Userspace Tracer (trace control library)
>
> $ apt-cache search liburcu
> liburcu-dev - a userspace RCU (read-copy-update) library - development fi=
les
> liburcu1 - a userspace RCU (read-copy-update) library
> liburcu2 - a userspace RCU (read-copy-update) library
>
> So it looks like my aptitude is not aware of a package called liburcu wit=
hout a postfix. Even if I'd purge and reinstall (which seems like a very go=
od idea) I don't see if I can access the right library this way.
>
> Yan Grange

If you visit https://launchpad.net/~lttng/+archive/ppa you'll see

babeltrace 	1.2.y+stable+bzr710+pack25+201412120847~ubuntu15.04.1
liburcu	 	0.8.x+stable+bzr1060+pack22+201411140046~ubuntu15.04.1
lttng-modules 	2.5.x+stable+bzr634+pack21+201412111931~ubuntu15.04.1
lttng-tools 	2.5.x+stable+bzr2423+pack12+201412110246~ubuntu15.04.1
lttng-ust 	2.5.x+stable+bzr1802+pack45+201412111801~ubuntu15.04.1

   The packages you see in http://ppa.launchpad.net/lttng/ppa/ubuntu depend=
 on your hardware.  We have:

amd64:
liburcu-dev
lttng-modules-dkms
lttng-tools
babeltrace
libbabeltrace0
liburcu1
libbabeltrace-dev
liblttng-ust0
liblttng-ust-dev
liblttng-ctl-dev
liblttng-ctl0
libbabeltrace-ctf-dev
libbabeltrace-ctf0
liblttng-ust-java-jni
liblttng-ust-java
liburcu2
python-lttng
liblttng-ust-ctl2
libbabeltrace1
libbabeltrace-ctf1
python3-babeltrace

armel:
lttng-modules-dkms
liblttng-ust-java

armhf:
lttng-modules-dkms
liblttng-ust-java

i386:
liburcu-dev
lttng-modules-dkms
lttng-tools
babeltrace
libbabeltrace0
liburcu1
libbabeltrace-dev
liblttng-ust0
liblttng-ust-dev
liblttng-ctl-dev
liblttng-ctl0
libbabeltrace-ctf-dev
libbabeltrace-ctf0
liblttng-ust-java-jni
liblttng-ust-java
liburcu2
python-lttng
liblttng-ust-ctl2
libbabeltrace1
libbabeltrace-ctf1
python3-babeltrace

   Your listings seem all right; the difference is source vs binary: the so=
urce package liburcu builds the binary packages liburcu-dev, liburcu1 and l=
iburcu2, for instance.  (I'm more used to building from source)

   Ignoring the babeltrace packages, the dependencies are such that this is=
 the minimal install: liblttng-ust-dev, liblttng-ctl-dev, lttng-tools.  Opt=
ionally, liblttng-ust-java, python-lttng, lttng-modules-dkms.  Turns out li=
burcu1 is not connected to anything (I think it's for older releases).

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
