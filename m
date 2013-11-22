From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Building LTTNG as a debian package
Date: Thu, 21 Nov 2013 19:11:31 -0500
Message-ID: <528EA133.1090500__4590.08326656676$1385079177$gmane$org@voxpopuli.im>
References: <CAKvQZ_3Kus-9FnXmn_qJtVux_U+U5nPUis2es_Ws0NeMXxWqpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1VjeLT-0000l5-GU
	for lttng-dev@lists.lttng.org; Thu, 21 Nov 2013 19:11:54 -0500
In-Reply-To: <CAKvQZ_3Kus-9FnXmn_qJtVux_U+U5nPUis2es_Ws0NeMXxWqpQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Willy Lambert <lambert.willy@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

The packaging for distributions is usually managed by the distribution
itself, not the upstream project.

For the official Debian packages, you can search on packages.debian.org
for the package names, and from there you can download the
*.debian.tar.gz for the packaging "recipe". Or follow the links to get
to the git tree where it is stored. For example, for the lttng-modules
package:
http://anonscm.debian.org/gitweb/?p=collab-maint/lttng-modules.git;a=summary

We also maintain a Ubuntu PPA which does automatic builds from git
roughly every day. If you want to package a git snapshot, you may find
those useful:
https://code.launchpad.net/~lttng
(under the *-packaging-daily branches)


Cheers,
Alexandre


On 13-11-21 06:24 PM, Willy Lambert wrote:
> Hi all,
>
> I have successfully build an embedded target with the LTTNG toolset and I'm
> now trying to package this to be able to repopulate a target from scratch.
>
> I'm starting with the kernel modules and I did not succeed in building them
> with make-kpkg modules_images.
>
> As I have seen you produce Debian packages for recent distributions, I
> wonder if your packaging architecture is available somewhere (I had q quick
> look on git but debian packaging infrastructure isn't present).
>
> Or maybe is there any documentation on this ?
>
> Regards.
>
