From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: checkinstall and lttng-ust with Java/JNI support
Date: Wed, 24 Apr 2013 17:48:21 -0400
Message-ID: <51785325.3030509__16452.8560395867$1366840290$gmane$org@voxpopuli.im>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D10094@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1UV7aj-0000nG-Tb
	for lttng-dev@lists.lttng.org; Wed, 24 Apr 2013 17:51:05 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D10094@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

On 13-04-24 05:25 PM, Thibault, Daniel wrote:
>    I was fooling around with checkinstall in order to create installation=
 packages for lttng-modules, userspace-rcu, etc., when I ran into what seem=
s a very obscure bug (googling for the error message "unable to create `/pr=
oc/self/coredump_filter.dpkg-new'" brings up nothing).
>
>    It occurs when building the Debian package for lttng-ust, but only if =
Java/JNI support was requested. That is to say, building lttng-ust with no =
extra support or with just systemtap support packages just fine.
>
>    But when I build it with JNI/Java support, the 'sudo checkinstall make=
 install' runs into this at the end:
>
> Selecting previously unselected package lttng-ust-java.
> (Reading database ... 147274 files and directories currently installed.)
> Unpacking lttng-ust-java (from .../lttng-ust-java_2.2.0-rc1-12_amd64.deb)=
 ...
> dpkg: error processing /home/daniel/Documents/git.lttng.org/lttng-ust-2.2=
.0-rc1+-a16877a-Java/lttng-ust-java_2.2.0-rc1-12_amd64.deb (--install):
>  unable to create `/proc/self/coredump_filter.dpkg-new' (while processing=
 `./proc/self/coredump_filter'): No such file or directory
> Processing triggers for man-db ...
> Errors were encountered while processing:
>  /home/daniel/Documents/git.lttng.org/lttng-ust-2.2.0-rc1+-a16877a-Java/l=
ttng-ust-java_2.2.0-rc1-12_amd64.deb
>
>    Note that the install supervised by checkinstall worked fine, and the =
package was built successfully: the problem occurs when the package is fed =
to apt, it seems.  The resulting package will cause the same error when run=
 through the Ubuntu Software Centre, for instance, meaning it is unusable.
>
>    Any clues as to what is failing here?

checkinstall has always been kind of sloppy. You could get some insight
by printing the contents of the package (by doing "dpkg-deb --contents
<package-name>.deb"), it could be an invalid character somewhere, a path
it doesn't recognize, etc.

But if you want to build .deb packages to install on something other
than your own machine, you should really use dpkg-buildpackage or, even
better, pbuilder. Those require proper packaging information in a
debian/ sub-directory. You can look at the debian/ directories in the
Ubuntu packages (which you can get with "apt-get source lttng-ust"), it
should be straightforward to tweak it to your needs.


Cheers,
Alexandre

>
> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
