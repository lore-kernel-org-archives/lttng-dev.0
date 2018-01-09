From: Majid Rezazadeh <majid3612@gmail.com>
Subject: Re: lttng-dev Digest, Vol 117, Issue 3
Date: Tue, 9 Jan 2018 17:51:45 -0500
Message-ID: <CACbQsw_kZpBaAY=xs5Q7XiZ52dzqJPJHBF7bjR7vpSgoq2ZPBg__22312.2970587157$1515538201$gmane$org@mail.gmail.com>
References: <mailman.96.1515533192.465.lttng-dev@lists.lttng.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2898309727610786990=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pg0-x230.google.com (mail-pg0-x230.google.com
 [IPv6:2607:f8b0:400e:c05::230])
 by lists.lttng.org (Postfix) with ESMTPS id 3zGS7S04BwzpSW
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jan 2018 22:51:47 +0000 (UTC)
Received: by mail-pg0-x230.google.com with SMTP id z17so3104292pgc.4
 for <lttng-dev@lists.lttng.org>; Tue, 09 Jan 2018 14:51:47 -0800 (PST)
In-Reply-To: <mailman.96.1515533192.465.lttng-dev@lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, gbastien+lttng@versatic.net
List-Id: lttng-dev@lists.lttng.org

--===============2898309727610786990==
Content-Type: multipart/alternative; boundary="94eb2c14070260bb3105625fc2c8"

--94eb2c14070260bb3105625fc2c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Genevi=C3=A8ve,

Thank you for your response.

I had tried your solution before. Unfortunately, there is no difference
between preloading one or two other shared libraries with my test library.
I am not sure about the reason, maybe a conflict between lttng and firefox
in access to shared resource.

Majid



On Tue, Jan 9, 2018 at 4:26 PM, <lttng-dev-request@lists.lttng.org> wrote:

> Send lttng-dev mailing list submissions to
>         lttng-dev@lists.lttng.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> or, via email, send a message with subject or body 'help' to
>         lttng-dev-request@lists.lttng.org
>
> You can reach the person managing the list at
>         lttng-dev-owner@lists.lttng.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of lttng-dev digest..."
>
>
> Today's Topics:
>
>    1. Re: LD_PRELOAD applications using lttng-ust-pthread
>       (Jonathan Rajotte-Julien)
>    2. Re: LD_PRELOAD applications using lttng-ust-pthread
>       (Jonathan Rajotte-Julien)
>    3. Re: LD_PRELOAD applications using lttng-ust-pthread
>       (Genevieve Bastien)
>    4. [PATCH lttng-modules 3/3] Fix: Update btrfs       instrumentation
>       for v4.15 (Michael Jeanson)
>    5. [PATCH lttng-modules 2/3] Update kvm instrumentation      for
>       debian kernel 4.9.65-3 (Michael Jeanson)
>    6. [PATCH lttng-modules 1/3] Fix: debian kernel version      parsing
>       (Michael Jeanson)
>    7. Re: [PATCH lttng-modules 3/3] Fix: Update btrfs
>       instrumentation for v4.15 (Mathieu Desnoyers)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 9 Jan 2018 10:43:51 -0500
> From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
> To: Majid Rezazadeh <majid3612@gmail.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] LD_PRELOAD applications using
>         lttng-ust-pthread
> Message-ID: <20180109154351.GA17950@joraj-alpa>
> Content-Type: text/plain; charset=3Dus-ascii
>
> Hi,
>
> On Mon, Jan 08, 2018 at 10:35:39PM -0500, Majid Rezazadeh wrote:
> > Hi all
> >
> > I am using lttng-ust-libc-wrapper for instrumenting some calls to libc
> for
> > some applications like Firefox and Chrome, but I receive "Segmentation
> > fault (core dumped)". I compile lttng-ust-pthread.c (gcc -fPIC -shared
> -o
> > test.so lttng-ust-pthread.c -ldl) and then I use "LD_PRELOAD=3Dtest.so
> > firefox" but I receive segmentation fault (I have exported
> LD_LIBRARY_PATH
> > to the absolute path of test.so file). I found out that when I replace
>
> Could you give us more information regarding the coredump?
>
> "thread apply all bt" in gdb with the corefile loaded.
>
> Make sure to compile with debug symbol and rerun your test.
>
> > tracepoints with printf in lttng_ust_pthread.c, I receive no error. It
> > seems that hooking tracepoints in this wrapper makes some problems. Do
> you
> > have any idea in this regard?
> >
> > Thanks
> >
> > Majid
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 9 Jan 2018 10:47:10 -0500
> From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
> To: Majid Rezazadeh <majid3612@gmail.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] LD_PRELOAD applications using
>         lttng-ust-pthread
> Message-ID: <20180109154710.GB17950@joraj-alpa>
> Content-Type: text/plain; charset=3Dus-ascii
>
> On Tue, Jan 09, 2018 at 10:43:51AM -0500, Jonathan Rajotte-Julien wrote:
> > Hi,
> >
> > On Mon, Jan 08, 2018 at 10:35:39PM -0500, Majid Rezazadeh wrote:
> > > Hi all
> > >
> > > I am using lttng-ust-libc-wrapper for instrumenting some calls to lib=
c
> for
> > > some applications like Firefox and Chrome, but I receive "Segmentatio=
n
> > > fault (core dumped)". I compile lttng-ust-pthread.c (gcc -fPIC
> -shared  -o
> > > test.so lttng-ust-pthread.c -ldl) and then I use "LD_PRELOAD=3Dtest.s=
o
> > > firefox" but I receive segmentation fault (I have exported
> LD_LIBRARY_PATH
> > > to the absolute path of test.so file). I found out that when I replac=
e
> >
> > Could you give us more information regarding the coredump?
> >
> > "thread apply all bt" in gdb with the corefile loaded.
> >
> > Make sure to compile with debug symbol and rerun your test.
>
> Forgot to mention that you should open a bug here:
>
> https://bugs.lttng.org/
>
> Make sure to read the bug reporting guidelines.
>
> Cheers!
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 9 Jan 2018 10:34:18 -0500
> From: Genevieve Bastien <gbastien+lttng@versatic.net>
> To: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] LD_PRELOAD applications using
>         lttng-ust-pthread
> Message-ID: <bfd757ed-4b3e-1294-f476-34a2b373acac@versatic.net>
> Content-Type: text/plain; charset=3D"utf-8"
>
> Hi Majid,
>
>
> See the documentation here:
> http://lttng.org/docs/v2.10/#doc-using-lttng-ust-with-daemons and
> http://lttng.org/docs/v2.10/#doc-liblttng-ust-fd. Firefox requires at
> least one of those extra libraries to be preloaded, the one for fork I
> think.
>
>
> I recall trying to trace firefox with lttng-cyg-profile without much
> success. Without the liblttng-ust-fork.so preloaded, my tabs had
> segfaults. But when I tried with both libraries, it seemed there was a
> conflict between cyg-profile and the other preloaded libraries, I don't
> remember exactly what happened. Maybe you won't have this problem with
> lttng-ust-libc-wrapper.
>
>
> I hope this helps,
>
> Genevi=C3=A8ve
>
>
> On 2018-01-08 10:35 PM, Majid Rezazadeh wrote:
> > Hi all
> >
> > I am using lttng-ust-libc-wrapper for instrumenting some calls to libc
> > for some applications like Firefox and Chrome, but I receive
> > "Segmentation fault (core dumped)". I compile lttng-ust-pthread.c (gcc
> > -fPIC -shared  -o test.so lttng-ust-pthread.c -ldl) and then I use
> > "LD_PRELOAD=3Dtest.so firefox" but I receive segmentation fault (I have
> > exported LD_LIBRARY_PATH to the absolute path of test.so file). I
> > found out that when I replace tracepoints with printf in
> > lttng_ust_pthread.c, I receive no error. It seems that hooking
> > tracepoints in this wrapper makes some problems. Do you have any idea
> > in this regard?
> >
> > Thanks
> >
> > Majid
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <https://lists.lttng.org/pipermail/lttng-dev/attachments/
> 20180109/3b570b98/attachment-0001.html>
>
> ------------------------------
>
> Message: 4
> Date: Tue,  9 Jan 2018 15:43:21 -0500
> From: Michael Jeanson <mjeanson@efficios.com>
> To: lttng-dev@lists.lttng.org
> Subject: [lttng-dev] [PATCH lttng-modules 3/3] Fix: Update btrfs
>         instrumentation for v4.15
> Message-ID: <1515530601-19259-3-git-send-email-mjeanson@efficios.com>
>
> See upstream commit:
>
>   commit d278850eff3053ef166cf64c16f798dfe36278a2
>   Author: Josef Bacik <josef@toxicpanda.com>
>   Date:   Fri Sep 29 15:43:57 2017 -0400
>
>     btrfs: remove delayed_ref_node from ref_head
>
>     This is just excessive information in the ref_head, and makes the cod=
e
>     complicated.  It is a relic from when we had the heads and the refs i=
n
>     the same tree, which is no longer the case.  With this removal I've
>     cleaned up a bunch of the cruft around this old assumption as well.
>
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  instrumentation/events/lttng-module/btrfs.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/instrumentation/events/lttng-module/btrfs.h
> b/instrumentation/events/lttng-module/btrfs.h
> index b529e8e..7901f05 100644
> --- a/instrumentation/events/lttng-module/btrfs.h
> +++ b/instrumentation/events/lttng-module/btrfs.h
> @@ -680,7 +680,23 @@ LTTNG_TRACEPOINT_EVENT(btrfs_delayed_data_ref,
>         )
>  )
>
> -#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,8,0))
> +#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,15,0))
> +LTTNG_TRACEPOINT_EVENT(btrfs_delayed_ref_head,
> +
> +       TP_PROTO(struct btrfs_fs_info *fs_info,
> +                struct btrfs_delayed_ref_head *head_ref,
> +                int action),
> +
> +       TP_ARGS(fs_info, head_ref, action),
> +
> +       TP_FIELDS(
> +               ctf_integer(u64, bytenr, head_ref->bytenr)
> +               ctf_integer(u64, num_bytes, head_ref->num_bytes)
> +               ctf_integer(int, action, action)
> +               ctf_integer(int, is_data, head_ref->is_data)
> +       )
> +)
> +#elif (LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,8,0))
>  LTTNG_TRACEPOINT_EVENT(btrfs_delayed_ref_head,
>
>         TP_PROTO(struct btrfs_fs_info *fs_info,
> --
> 2.7.4
>
>
>
> ------------------------------
>
> Message: 5
> Date: Tue,  9 Jan 2018 15:43:20 -0500
> From: Michael Jeanson <mjeanson@efficios.com>
> To: lttng-dev@lists.lttng.org
> Subject: [lttng-dev] [PATCH lttng-modules 2/3] Update kvm
>         instrumentation for debian kernel 4.9.65-3
> Message-ID: <1515530601-19259-2-git-send-email-mjeanson@efficios.com>
>
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  instrumentation/events/lttng-module/kvm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/instrumentation/events/lttng-module/kvm.h
> b/instrumentation/events/lttng-module/kvm.h
> index ea63e88..d9d0300 100644
> --- a/instrumentation/events/lttng-module/kvm.h
> +++ b/instrumentation/events/lttng-module/kvm.h
> @@ -86,7 +86,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_ack_irq,
>
>  #if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,15,0) \
>         || LTTNG_KERNEL_RANGE(3,16,52, 3,17,0) \
> -       || LTTNG_KERNEL_RANGE(3,2,97, 3,3,0))
> +       || LTTNG_KERNEL_RANGE(3,2,97, 3,3,0) \
> +       || LTTNG_DEBIAN_KERNEL_RANGE(4,9,65,0,3,0, 4,10,0,0,0,0))
>
>  LTTNG_TRACEPOINT_EVENT(kvm_mmio,
>         TP_PROTO(int type, int len, u64 gpa, void *val),
> --
> 2.7.4
>
>
>
> ------------------------------
>
> Message: 6
> Date: Tue,  9 Jan 2018 15:43:19 -0500
> From: Michael Jeanson <mjeanson@efficios.com>
> To: lttng-dev@lists.lttng.org
> Subject: [lttng-dev] [PATCH lttng-modules 1/3] Fix: debian kernel
>         version parsing
> Message-ID: <1515530601-19259-1-git-send-email-mjeanson@efficios.com>
>
> The debian version script only worked for ckt kernels and that was fine
> until now because we only had checks for those versions in the code.
>
> ckt (Canonical Kernel Team) kernels were used for a while during the jess=
ie
> cycle, their versionning is a bit different. They track the upstream
> vanilla
> stable updates but they don't update the minor version number and instead
> add
> an additionnal -cktX. They were all 3.16.7-cktX and after a while the
> version
> switched back to upstream style at 3.16.36.
>
> Knowing that, we can compare regular debian and ckt kernel versions
> using this scheme :
>
>   MAJOR.PATCHLEVEL.SUBLEVEL.CKT.DEBABI.DEBPATCH
>
> And setting CKT to zero for non-ckt kernels.
>
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  abi-debian-version.sh | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/abi-debian-version.sh b/abi-debian-version.sh
> index 310d6a8..36da212 100755
> --- a/abi-debian-version.sh
> +++ b/abi-debian-version.sh
> @@ -12,24 +12,26 @@ fi
>
>  # Assuming KPATH is the target kernel headers directory
>  DEB_PACKAGE_VERSION=3D$(sed -rn 's/^#define LINUX_PACKAGE_ID " Debian
> (.*)"/\1/p' ${KPATH}/include/generated/package.h)
> +
>  # Ignore backports part
>  DEB_PACKAGE_VERSION=3D$(echo ${DEB_PACKAGE_VERSION} | sed -r
> 's/~(bpo|deb).*//')
> +
> +# ckt (Canonical Kernel Team) kernels were used for a while during the
> jessie
> +# cycle, their versionning is a bit different. They track the upstream
> vanilla
> +# stable updates but they don't update the minor version number and
> instead add
> +# an additionnal -cktX. They were all 3.16.7-cktX and after a while the
> version
> +# switched back to upstream style at 3.16.36.
> +
>  # Get -ckt update number, if present
>  KERNEL_CKT_UPDATE=3D$(echo ${DEB_PACKAGE_VERSION} | sed -rn
> 's/^[0-9]+\.[0-9]+\.[0-9]+-ckt([0-9]+).*/\1/p')
> -
> -# Only care about the rest if it is a -ckt kernel, making sure we do not
> -# clash with older Debian kernels (e.g. Debian 3.2.65-1+deb7u2).
> -if [ -z "${KERNEL_CKT_UPDATE}" ]; then
> -       echo 0
> -       exit 0
> -fi
> +test -n "${KERNEL_CKT_UPDATE}" || KERNEL_CKT_UPDATE=3D0
>
>  # Get package revision
>  DEB_PACKAGE_REVISION=3D$(echo ${DEB_PACKAGE_VERSION} | sed -r
> 's/.*-([^-]+)$/\1/')
>  # Get non-sec update number
>  DEB_PACKAGE_REVISION_BASE=3D$(echo ${DEB_PACKAGE_REVISION} | sed -r
> 's/^([0-9]+).*/\1/')
>  # Get security update number, if present
> -DEB_PACKAGE_REVISION_SECURITY=3D$(echo ${DEB_PACKAGE_REVISION} | sed -rn
> 's/.*\+(squeeze|deb[0-9])+u([0-9]+)$/\1/p')
> +DEB_PACKAGE_REVISION_SECURITY=3D$(echo ${DEB_PACKAGE_REVISION} | sed -rn
> 's/.*\+(squeeze|deb[0-9]+)+u([0-9]+)$/\2/p')
>  test -n "${DEB_PACKAGE_REVISION_SECURITY}" ||
> DEB_PACKAGE_REVISION_SECURITY=3D0
>  # Combine all update numbers into one
>  DEB_API_VERSION=3D$((KERNEL_CKT_UPDATE * 10000 + DEB_PACKAGE_REVISION_BA=
SE
> * 100 + DEB_PACKAGE_REVISION_SECURITY))
> --
> 2.7.4
>
>
>
> ------------------------------
>
> Message: 7
> Date: Tue, 9 Jan 2018 21:29:55 +0000 (UTC)
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: Michael Jeanson <mjeanson@efficios.com>
> Cc: lttng-dev <lttng-dev@lists.lttng.org>
> Subject: Re: [lttng-dev] [PATCH lttng-modules 3/3] Fix: Update btrfs
>         instrumentation for v4.15
> Message-ID:
>         <2113123048.49851.1515533395136.JavaMail.zimbra@efficios.com>
> Content-Type: text/plain; charset=3Dutf-8
>
> ----- On Jan 9, 2018, at 3:43 PM, Michael Jeanson mjeanson@efficios.com
> wrote:
>
> > See upstream commit:
> >
> >  commit d278850eff3053ef166cf64c16f798dfe36278a2
> >  Author: Josef Bacik <josef@toxicpanda.com>
> >  Date:   Fri Sep 29 15:43:57 2017 -0400
> >
> >    btrfs: remove delayed_ref_node from ref_head
> >
> >    This is just excessive information in the ref_head, and makes the co=
de
> >    complicated.  It is a relic from when we had the heads and the refs =
in
> >    the same tree, which is no longer the case.  With this removal I've
> >    cleaned up a bunch of the cruft around this old assumption as well.
>
> In 3.12, this becomes a DECLARE_EVENT_CLASS with associated DEFINE_EVENT
> using the class. Example code snippet from a 4.15-rc kernel:
>
> DECLARE_EVENT_CLASS(btrfs_delayed_ref_head,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info,
>                  const struct btrfs_delayed_ref_head *head_ref,
>                  int action),
>
>         TP_ARGS(fs_info, head_ref, action),
>
>         TP_STRUCT__entry_btrfs(
>                 __field(        u64,  bytenr            )
>                 __field(        u64,  num_bytes         )
>                 __field(        int,  action            )
>                 __field(        int,  is_data           )
>         ),
>
>         TP_fast_assign_btrfs(fs_info,
>                 __entry->bytenr         =3D head_ref->bytenr;
>                 __entry->num_bytes      =3D head_ref->num_bytes;
>                 __entry->action         =3D action;
>                 __entry->is_data        =3D head_ref->is_data;
>         ),
>
>         TP_printk_btrfs("bytenr=3D%llu num_bytes=3D%llu action=3D%s is_da=
ta=3D%d",
>                   (unsigned long long)__entry->bytenr,
>                   (unsigned long long)__entry->num_bytes,
>                   show_ref_action(__entry->action),
>                   __entry->is_data)
> );
>
> DEFINE_EVENT(btrfs_delayed_ref_head,  add_delayed_ref_head,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info,
>                  const struct btrfs_delayed_ref_head *head_ref,
>                  int action),
>
>         TP_ARGS(fs_info, head_ref, action)
> );
>
> DEFINE_EVENT(btrfs_delayed_ref_head,  run_delayed_ref_head,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info,
>                  const struct btrfs_delayed_ref_head *head_ref,
>                  int action),
>
>         TP_ARGS(fs_info, head_ref, action)
> );
>
> It appears that this instrumentation has not been hooked on any actual
> tracepoint for quite some time in lttng-modules.
>
> We should adapt the lttng-modules instrumentation accordingly. I would
> not be surprised that the 4.8.0 kernel version range is also incorrect:
> it should apply to the "new" events based on the tracepoint class.
>
> Thanks,
>
> Mathieu
>
> >
> > Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> > ---
> > instrumentation/events/lttng-module/btrfs.h | 18 +++++++++++++++++-
> > 1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/instrumentation/events/lttng-module/btrfs.h
> > b/instrumentation/events/lttng-module/btrfs.h
> > index b529e8e..7901f05 100644
> > --- a/instrumentation/events/lttng-module/btrfs.h
> > +++ b/instrumentation/events/lttng-module/btrfs.h
> > @@ -680,7 +680,23 @@ LTTNG_TRACEPOINT_EVENT(btrfs_delayed_data_ref,
> >       )
> > )
> >
> > -#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,8,0))
> > +#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,15,0))
> > +LTTNG_TRACEPOINT_EVENT(btrfs_delayed_ref_head,
> > +
> > +     TP_PROTO(struct btrfs_fs_info *fs_info,
> > +              struct btrfs_delayed_ref_head *head_ref,
> > +              int action),
> > +
> > +     TP_ARGS(fs_info, head_ref, action),
> > +
> > +     TP_FIELDS(
> > +             ctf_integer(u64, bytenr, head_ref->bytenr)
> > +             ctf_integer(u64, num_bytes, head_ref->num_bytes)
> > +             ctf_integer(int, action, action)
> > +             ctf_integer(int, is_data, head_ref->is_data)
> > +     )
> > +)
> > +#elif (LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,8,0))
> > LTTNG_TRACEPOINT_EVENT(btrfs_delayed_ref_head,
> >
> >       TP_PROTO(struct btrfs_fs_info *fs_info,
> > --
> > 2.7.4
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> ------------------------------
>
> End of lttng-dev Digest, Vol 117, Issue 3
> *****************************************
>

--94eb2c14070260bb3105625fc2c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Genevi=C3=A8ve,</div><div><br></div><div>Thank you=
 for your response.</div><div><br></div><div>I had tried your solution befo=
re. Unfortunately, there is no difference between preloading one or two oth=
er shared libraries with my test library. I am not sure about the reason, m=
aybe a conflict between lttng and firefox in access to shared resource.</di=
v><div><br></div><div>Majid=C2=A0</div><div><br></div><br><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Tue, Jan 9, 2018 at 4:26 PM,  <=
span dir=3D"ltr">&lt;<a href=3D"mailto:lttng-dev-request@lists.lttng.org" t=
arget=3D"_blank">lttng-dev-request@lists.<wbr>lttng.org</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Send lttng-dev mail=
ing list submissions to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists.lttng.org" ta=
rget=3D"_blank">lttng-dev@lists.lttng.org</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bi<wbr>n/mailman/listinfo/lttng-dev</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev-request@lists.lttng=
.org" target=3D"_blank">lttng-dev-request@lists.lttng.<wbr>org</a><br>
<br>
You can reach the person managing the list at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev-owner@lists.lttng.o=
rg" target=3D"_blank">lttng-dev-owner@lists.lttng.or<wbr>g</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of lttng-dev digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
=C2=A0 =C2=A01. Re: LD_PRELOAD applications using lttng-ust-pthread<br>
=C2=A0 =C2=A0 =C2=A0 (Jonathan Rajotte-Julien)<br>
=C2=A0 =C2=A02. Re: LD_PRELOAD applications using lttng-ust-pthread<br>
=C2=A0 =C2=A0 =C2=A0 (Jonathan Rajotte-Julien)<br>
=C2=A0 =C2=A03. Re: LD_PRELOAD applications using lttng-ust-pthread<br>
=C2=A0 =C2=A0 =C2=A0 (Genevieve Bastien)<br>
=C2=A0 =C2=A04. [PATCH lttng-modules 3/3] Fix: Update btrfs=C2=A0 =C2=A0 =
=C2=A0 =C2=A0instrumentation<br>
=C2=A0 =C2=A0 =C2=A0 for v4.15 (Michael Jeanson)<br>
=C2=A0 =C2=A05. [PATCH lttng-modules 2/3] Update kvm instrumentation=C2=A0 =
=C2=A0 =C2=A0 for<br>
=C2=A0 =C2=A0 =C2=A0 debian kernel 4.9.65-3 (Michael Jeanson)<br>
=C2=A0 =C2=A06. [PATCH lttng-modules 1/3] Fix: debian kernel version=C2=A0 =
=C2=A0 =C2=A0 parsing<br>
=C2=A0 =C2=A0 =C2=A0 (Michael Jeanson)<br>
=C2=A0 =C2=A07. Re: [PATCH lttng-modules 3/3] Fix: Update btrfs<br>
=C2=A0 =C2=A0 =C2=A0 instrumentation for v4.15 (Mathieu Desnoyers)<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-----<br>
<br>
Message: 1<br>
Date: Tue, 9 Jan 2018 10:43:51 -0500<br>
From: Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien=
@efficios.com" target=3D"_blank">jonathan.rajotte-julien@effic<wbr>ios.com<=
/a>&gt;<br>
To: Majid Rezazadeh &lt;<a href=3D"mailto:majid3612@gmail.com" target=3D"_b=
lank">majid3612@gmail.com</a>&gt;<br>
Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: Re: [lttng-dev] LD_PRELOAD applications using<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-ust-pthread<br>
Message-ID: &lt;20180109154351.GA17950@joraj-<wbr>alpa&gt;<br>
Content-Type: text/plain; charset=3Dus-ascii<br>
<br>
Hi,<br>
<br>
On Mon, Jan 08, 2018 at 10:35:39PM -0500, Majid Rezazadeh wrote:<br>
&gt; Hi all<br>
&gt;<br>
&gt; I am using lttng-ust-libc-wrapper for instrumenting some calls to libc=
 for<br>
&gt; some applications like Firefox and Chrome, but I receive &quot;Segment=
ation<br>
&gt; fault (core dumped)&quot;. I compile lttng-ust-pthread.c (gcc -fPIC -s=
hared=C2=A0 -o<br>
&gt; test.so lttng-ust-pthread.c -ldl) and then I use &quot;LD_PRELOAD=3Dte=
st.so<br>
&gt; firefox&quot; but I receive segmentation fault (I have exported LD_LIB=
RARY_PATH<br>
&gt; to the absolute path of test.so file). I found out that when I replace=
<br>
<br>
Could you give us more information regarding the coredump?<br>
<br>
&quot;thread apply all bt&quot; in gdb with the corefile loaded.<br>
<br>
Make sure to compile with debug symbol and rerun your test.<br>
<br>
&gt; tracepoints with printf in lttng_ust_pthread.c, I receive no error. It=
<br>
&gt; seems that hooking tracepoints in this wrapper makes some problems. Do=
 you<br>
&gt; have any idea in this regard?<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; Majid<br>
<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/=
mailman/listinfo/lttng-dev</a><br>
<br>
<br>
--<br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Tue, 9 Jan 2018 10:47:10 -0500<br>
From: Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien=
@efficios.com" target=3D"_blank">jonathan.rajotte-julien@effic<wbr>ios.com<=
/a>&gt;<br>
To: Majid Rezazadeh &lt;<a href=3D"mailto:majid3612@gmail.com" target=3D"_b=
lank">majid3612@gmail.com</a>&gt;<br>
Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: Re: [lttng-dev] LD_PRELOAD applications using<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-ust-pthread<br>
Message-ID: &lt;20180109154710.GB17950@joraj-<wbr>alpa&gt;<br>
Content-Type: text/plain; charset=3Dus-ascii<br>
<br>
On Tue, Jan 09, 2018 at 10:43:51AM -0500, Jonathan Rajotte-Julien wrote:<br=
>
&gt; Hi,<br>
&gt;<br>
&gt; On Mon, Jan 08, 2018 at 10:35:39PM -0500, Majid Rezazadeh wrote:<br>
&gt; &gt; Hi all<br>
&gt; &gt;<br>
&gt; &gt; I am using lttng-ust-libc-wrapper for instrumenting some calls to=
 libc for<br>
&gt; &gt; some applications like Firefox and Chrome, but I receive &quot;Se=
gmentation<br>
&gt; &gt; fault (core dumped)&quot;. I compile lttng-ust-pthread.c (gcc -fP=
IC -shared=C2=A0 -o<br>
&gt; &gt; test.so lttng-ust-pthread.c -ldl) and then I use &quot;LD_PRELOAD=
=3Dtest.so<br>
&gt; &gt; firefox&quot; but I receive segmentation fault (I have exported L=
D_LIBRARY_PATH<br>
&gt; &gt; to the absolute path of test.so file). I found out that when I re=
place<br>
&gt;<br>
&gt; Could you give us more information regarding the coredump?<br>
&gt;<br>
&gt; &quot;thread apply all bt&quot; in gdb with the corefile loaded.<br>
&gt;<br>
&gt; Make sure to compile with debug symbol and rerun your test.<br>
<br>
Forgot to mention that you should open a bug here:<br>
<br>
<a href=3D"https://bugs.lttng.org/" rel=3D"noreferrer" target=3D"_blank">ht=
tps://bugs.lttng.org/</a><br>
<br>
Make sure to read the bug reporting guidelines.<br>
<br>
Cheers!<br>
<br>
--<br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Tue, 9 Jan 2018 10:34:18 -0500<br>
From: Genevieve Bastien &lt;<a href=3D"mailto:gbastien%2Blttng@versatic.net=
" target=3D"_blank">gbastien+lttng@versatic.net</a>&gt;<br>
To: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: Re: [lttng-dev] LD_PRELOAD applications using<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-ust-pthread<br>
Message-ID: &lt;<a href=3D"mailto:bfd757ed-4b3e-1294-f476-34a2b373acac@vers=
atic.net" target=3D"_blank">bfd757ed-4b3e-1294-f476-34a2b<wbr>373acac@versa=
tic.net</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
Hi Majid,<br>
<br>
<br>
See the documentation here:<br>
<a href=3D"http://lttng.org/docs/v2.10/#doc-using-lttng-ust-with-daemons" r=
el=3D"noreferrer" target=3D"_blank">http://lttng.org/docs/v2.10/#d<wbr>oc-u=
sing-lttng-ust-with-daemon<wbr>s</a> and<br>
<a href=3D"http://lttng.org/docs/v2.10/#doc-liblttng-ust-fd" rel=3D"norefer=
rer" target=3D"_blank">http://lttng.org/docs/v2.10/#d<wbr>oc-liblttng-ust-f=
d</a>. Firefox requires at<br>
least one of those extra libraries to be preloaded, the one for fork I<br>
think.<br>
<br>
<br>
I recall trying to trace firefox with lttng-cyg-profile without much<br>
success. Without the liblttng-ust-fork.so preloaded, my tabs had<br>
segfaults. But when I tried with both libraries, it seemed there was a<br>
conflict between cyg-profile and the other preloaded libraries, I don&#39;t=
<br>
remember exactly what happened. Maybe you won&#39;t have this problem with<=
br>
lttng-ust-libc-wrapper.<br>
<br>
<br>
I hope this helps,<br>
<br>
Genevi=C3=A8ve<br>
<br>
<br>
On 2018-01-08 10:35 PM, Majid Rezazadeh wrote:<br>
&gt; Hi all<br>
&gt;<br>
&gt; I am using lttng-ust-libc-wrapper=C2=A0for instrumenting=C2=A0some cal=
ls to libc<br>
&gt; for some applications like Firefox and Chrome, but I receive<br>
&gt; &quot;Segmentation fault (core dumped)&quot;. I compile lttng-ust-pthr=
ead.c (gcc<br>
&gt; -fPIC -shared=C2=A0 -o test.so lttng-ust-pthread.c -ldl) and then I us=
e<br>
&gt; &quot;LD_PRELOAD=3Dtest.so firefox&quot; but I receive segmentation fa=
ult (I have<br>
&gt; exported LD_LIBRARY_PATH to the absolute path of test.so file). I<br>
&gt; found out that when I replace tracepoints with printf in<br>
&gt; lttng_ust_pthread.c, I receive no error. It seems that hooking<br>
&gt; tracepoints in this wrapper makes some problems. Do you have any idea<=
br>
&gt; in this regard?<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; Majid<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/=
mailman/listinfo/lttng-dev</a><br>
<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
URL: &lt;<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/attachments=
/20180109/3b570b98/attachment-0001.html" rel=3D"noreferrer" target=3D"_blan=
k">https://lists.lttng.org/piper<wbr>mail/lttng-dev/attachments/<wbr>201801=
09/3b570b98/attachment-<wbr>0001.html</a>&gt;<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Tue,=C2=A0 9 Jan 2018 15:43:21 -0500<br>
From: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com" target=
=3D"_blank">mjeanson@efficios.com</a>&gt;<br>
To: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: [lttng-dev] [PATCH lttng-modules 3/3] Fix: Update btrfs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 instrumentation for v4.15<br>
Message-ID: &lt;<a href=3D"mailto:1515530601-19259-3-git-send-email-mjeanso=
n@efficios.com" target=3D"_blank">1515530601-19259-3-git-send-e<wbr>mail-mj=
eanson@efficios.com</a>&gt;<br>
<br>
See upstream commit:<br>
<br>
=C2=A0 commit d278850eff3053ef166cf64c16f798<wbr>dfe36278a2<br>
=C2=A0 Author: Josef Bacik &lt;<a href=3D"mailto:josef@toxicpanda.com" targ=
et=3D"_blank">josef@toxicpanda.com</a>&gt;<br>
=C2=A0 Date:=C2=A0 =C2=A0Fri Sep 29 15:43:57 2017 -0400<br>
<br>
=C2=A0 =C2=A0 btrfs: remove delayed_ref_node from ref_head<br>
<br>
=C2=A0 =C2=A0 This is just excessive information in the ref_head, and makes=
 the code<br>
=C2=A0 =C2=A0 complicated.=C2=A0 It is a relic from when we had the heads a=
nd the refs in<br>
=C2=A0 =C2=A0 the same tree, which is no longer the case.=C2=A0 With this r=
emoval I&#39;ve<br>
=C2=A0 =C2=A0 cleaned up a bunch of the cruft around this old assumption as=
 well.<br>
<br>
Signed-off-by: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com"=
 target=3D"_blank">mjeanson@efficios.com</a>&gt;<br>
---<br>
=C2=A0instrumentation/events/lttng-<wbr>module/btrfs.h | 18 +++++++++++++++=
++-<br>
=C2=A01 file changed, 17 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/instrumentation/events/lttng<wbr>-module/btrfs.h b/instrumenta=
tion/events/lttng<wbr>-module/btrfs.h<br>
index b529e8e..7901f05 100644<br>
--- a/instrumentation/events/lttng<wbr>-module/btrfs.h<br>
+++ b/instrumentation/events/lttng<wbr>-module/btrfs.h<br>
@@ -680,7 +680,23 @@ LTTNG_TRACEPOINT_EVENT(btrfs_d<wbr>elayed_data_ref,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0)<br>
<br>
-#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(4,8,0))<br>
+#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(4,15,0))<br>
+LTTNG_TRACEPOINT_EVENT(btrfs_<wbr>delayed_ref_head,<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_PROTO(struct btrfs_fs_info *fs_info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct btrfs_delay=
ed_ref_head *head_ref,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int action),<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_ARGS(fs_info, head_ref, action),<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_FIELDS(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(u64, by=
tenr, head_ref-&gt;bytenr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(u64, nu=
m_bytes, head_ref-&gt;num_bytes)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(int, ac=
tion, action)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(int, is=
_data, head_ref-&gt;is_data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
+)<br>
+#elif (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(4,8,0))<br>
=C2=A0LTTNG_TRACEPOINT_EVENT(btrfs_<wbr>delayed_ref_head,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_PROTO(struct btrfs_fs_info *fs_info,<br>
--<br>
2.7.4<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 5<br>
Date: Tue,=C2=A0 9 Jan 2018 15:43:20 -0500<br>
From: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com" target=
=3D"_blank">mjeanson@efficios.com</a>&gt;<br>
To: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: [lttng-dev] [PATCH lttng-modules 2/3] Update kvm<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 instrumentation for debian kernel 4.9.65-3<br>
Message-ID: &lt;<a href=3D"mailto:1515530601-19259-2-git-send-email-mjeanso=
n@efficios.com" target=3D"_blank">1515530601-19259-2-git-send-e<wbr>mail-mj=
eanson@efficios.com</a>&gt;<br>
<br>
Signed-off-by: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com"=
 target=3D"_blank">mjeanson@efficios.com</a>&gt;<br>
---<br>
=C2=A0instrumentation/events/lttng-<wbr>module/kvm.h | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/instrumentation/events/lttng<wbr>-module/kvm.h b/instrumentati=
on/events/lttng<wbr>-module/kvm.h<br>
index ea63e88..d9d0300 100644<br>
--- a/instrumentation/events/lttng<wbr>-module/kvm.h<br>
+++ b/instrumentation/events/lttng<wbr>-module/kvm.h<br>
@@ -86,7 +86,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_ack<wbr>_irq,<br>
<br>
=C2=A0#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(4,15,0) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 || LTTNG_KERNEL_RANGE(3,16,52, 3,17,0) \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0|| LTTNG_KERNEL_RANGE(3,2,97, 3,3,0))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0|| LTTNG_KERNEL_RANGE(3,2,97, 3,3,0) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0|| LTTNG_DEBIAN_KERNEL_RANGE(4,9,<wbr>65,0,3,0,=
 4,10,0,0,0,0))<br>
<br>
=C2=A0LTTNG_TRACEPOINT_EVENT(kvm_mm<wbr>io,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_PROTO(int type, int len, u64 gpa, void *val)=
,<br>
--<br>
2.7.4<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 6<br>
Date: Tue,=C2=A0 9 Jan 2018 15:43:19 -0500<br>
From: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com" target=
=3D"_blank">mjeanson@efficios.com</a>&gt;<br>
To: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: [lttng-dev] [PATCH lttng-modules 1/3] Fix: debian kernel<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 version parsing<br>
Message-ID: &lt;<a href=3D"mailto:1515530601-19259-1-git-send-email-mjeanso=
n@efficios.com" target=3D"_blank">1515530601-19259-1-git-send-e<wbr>mail-mj=
eanson@efficios.com</a>&gt;<br>
<br>
The debian version script only worked for ckt kernels and that was fine<br>
until now because we only had checks for those versions in the code.<br>
<br>
ckt (Canonical Kernel Team) kernels were used for a while during the jessie=
<br>
cycle, their versionning is a bit different. They track the upstream vanill=
a<br>
stable updates but they don&#39;t update the minor version number and inste=
ad add<br>
an additionnal -cktX. They were all 3.16.7-cktX and after a while the versi=
on<br>
switched back to upstream style at 3.16.36.<br>
<br>
Knowing that, we can compare regular debian and ckt kernel versions<br>
using this scheme :<br>
<br>
=C2=A0 MAJOR.PATCHLEVEL.SUBLEVEL.CKT.<wbr>DEBABI.DEBPATCH<br>
<br>
And setting CKT to zero for non-ckt kernels.<br>
<br>
Signed-off-by: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com"=
 target=3D"_blank">mjeanson@efficios.com</a>&gt;<br>
---<br>
=C2=A0abi-debian-version.sh | 18 ++++++++++--------<br>
=C2=A01 file changed, 10 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/abi-debian-version.sh b/abi-debian-version.sh<br>
index 310d6a8..36da212 100755<br>
--- a/abi-debian-version.sh<br>
+++ b/abi-debian-version.sh<br>
@@ -12,24 +12,26 @@ fi<br>
<br>
=C2=A0# Assuming KPATH is the target kernel headers directory<br>
=C2=A0DEB_PACKAGE_VERSION=3D$(sed -rn &#39;s/^#define LINUX_PACKAGE_ID &quo=
t; Debian (.*)&quot;/\1/p&#39; ${KPATH}/include/generated/pac<wbr>kage.h)<b=
r>
+<br>
=C2=A0# Ignore backports part<br>
=C2=A0DEB_PACKAGE_VERSION=3D$(echo ${DEB_PACKAGE_VERSION} | sed -r &#39;s/~=
(bpo|deb).*//&#39;)<br>
+<br>
+# ckt (Canonical Kernel Team) kernels were used for a while during the jes=
sie<br>
+# cycle, their versionning is a bit different. They track the upstream van=
illa<br>
+# stable updates but they don&#39;t update the minor version number and in=
stead add<br>
+# an additionnal -cktX. They were all 3.16.7-cktX and after a while the ve=
rsion<br>
+# switched back to upstream style at 3.16.36.<br>
+<br>
=C2=A0# Get -ckt update number, if present<br>
=C2=A0KERNEL_CKT_UPDATE=3D$(echo ${DEB_PACKAGE_VERSION} | sed -rn &#39;s/^[=
0-9]+\.[0-9]+\.[0-9]+-ckt<wbr>([0-9]+).*/\1/p&#39;)<br>
-<br>
-# Only care about the rest if it is a -ckt kernel, making sure we do not<b=
r>
-# clash with older Debian kernels (e.g. Debian 3.2.65-1+deb7u2).<br>
-if [ -z &quot;${KERNEL_CKT_UPDATE}&quot; ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 0<br>
-fi<br>
+test -n &quot;${KERNEL_CKT_UPDATE}&quot; || KERNEL_CKT_UPDATE=3D0<br>
<br>
=C2=A0# Get package revision<br>
=C2=A0DEB_PACKAGE_REVISION=3D$(echo ${DEB_PACKAGE_VERSION} | sed -r &#39;s/=
.*-([^-]+)$/\1/&#39;)<br>
=C2=A0# Get non-sec update number<br>
=C2=A0DEB_PACKAGE_REVISION_BASE=3D$(e<wbr>cho ${DEB_PACKAGE_REVISION} | sed=
 -r &#39;s/^([0-9]+).*/\1/&#39;)<br>
=C2=A0# Get security update number, if present<br>
-DEB_PACKAGE_REVISION_SECURITY<wbr>=3D$(echo ${DEB_PACKAGE_REVISION} | sed =
-rn &#39;s/.*\+(squeeze|deb[0-9])+u([0<wbr>-9]+)$/\1/p&#39;)<br>
+DEB_PACKAGE_REVISION_SECURITY<wbr>=3D$(echo ${DEB_PACKAGE_REVISION} | sed =
-rn &#39;s/.*\+(squeeze|deb[0-9]+)+u([<wbr>0-9]+)$/\2/p&#39;)<br>
=C2=A0test -n &quot;${DEB_PACKAGE_REVISION_SECURI<wbr>TY}&quot; || DEB_PACK=
AGE_REVISION_SECURITY=3D<wbr>0<br>
=C2=A0# Combine all update numbers into one<br>
=C2=A0DEB_API_VERSION=3D$((KERNEL_<wbr>CKT_UPDATE * 10000 + DEB_PACKAGE_REV=
ISION_BASE * 100 + DEB_PACKAGE_REVISION_SECURITY)<wbr>)<br>
--<br>
2.7.4<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 7<br>
Date: Tue, 9 Jan 2018 21:29:55 +0000 (UTC)<br>
From: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.co=
m" target=3D"_blank">mathieu.desnoyers@efficios.co<wbr>m</a>&gt;<br>
To: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com" target=3D"=
_blank">mjeanson@efficios.com</a>&gt;<br>
Cc: lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_b=
lank">lttng-dev@lists.lttng.org</a>&gt;<br>
Subject: Re: [lttng-dev] [PATCH lttng-modules 3/3] Fix: Update btrfs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 instrumentation for v4.15<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:2113123048.49851.15155333=
95136.JavaMail.zimbra@efficios.com" target=3D"_blank">2113123048.49851.1515=
53339513<wbr>6.JavaMail.zimbra@efficios.com</a><wbr>&gt;<br>
Content-Type: text/plain; charset=3Dutf-8<br>
<br>
----- On Jan 9, 2018, at 3:43 PM, Michael Jeanson <a href=3D"mailto:mjeanso=
n@efficios.com" target=3D"_blank">mjeanson@efficios.com</a> wrote:<br>
<br>
&gt; See upstream commit:<br>
&gt;<br>
&gt;=C2=A0 commit d278850eff3053ef166cf64c16f798<wbr>dfe36278a2<br>
&gt;=C2=A0 Author: Josef Bacik &lt;<a href=3D"mailto:josef@toxicpanda.com" =
target=3D"_blank">josef@toxicpanda.com</a>&gt;<br>
&gt;=C2=A0 Date:=C2=A0 =C2=A0Fri Sep 29 15:43:57 2017 -0400<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 btrfs: remove delayed_ref_node from ref_head<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 This is just excessive information in the ref_head, and m=
akes the code<br>
&gt;=C2=A0 =C2=A0 complicated.=C2=A0 It is a relic from when we had the hea=
ds and the refs in<br>
&gt;=C2=A0 =C2=A0 the same tree, which is no longer the case.=C2=A0 With th=
is removal I&#39;ve<br>
&gt;=C2=A0 =C2=A0 cleaned up a bunch of the cruft around this old assumptio=
n as well.<br>
<br>
In 3.12, this becomes a DECLARE_EVENT_CLASS with associated DEFINE_EVENT<br=
>
using the class. Example code snippet from a 4.15-rc kernel:<br>
<br>
DECLARE_EVENT_CLASS(btrfs_dela<wbr>yed_ref_head,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_PROTO(const struct btrfs_fs_info *fs_info,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct =
btrfs_delayed_ref_head *head_ref,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int action),<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_ARGS(fs_info, head_ref, action),<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_STRUCT__entry_btrfs(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __field(=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u64,=C2=A0 bytenr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __field(=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u64,=C2=A0 num_bytes=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __field(=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int,=C2=A0 action=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __field(=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int,=C2=A0 is_data=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_fast_assign_btrfs(fs_info,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __entry-&gt;bytenr=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D head_ref-&gt;bytenr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __entry-&gt;num_byt=
es=C2=A0 =C2=A0 =C2=A0 =3D head_ref-&gt;num_bytes;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __entry-&gt;action=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D action;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __entry-&gt;is_data=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D head_ref-&gt;is_data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_printk_btrfs(&quot;bytenr=3D%llu num_bytes=
=3D%llu action=3D%s is_data=3D%d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned lo=
ng long)__entry-&gt;bytenr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned lo=
ng long)__entry-&gt;num_bytes,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 show_ref_act=
ion(__entry-&gt;actio<wbr>n),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __entry-&gt;=
is_data)<br>
);<br>
<br>
DEFINE_EVENT(btrfs_delayed_ref<wbr>_head,=C2=A0 add_delayed_ref_head,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_PROTO(const struct btrfs_fs_info *fs_info,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct =
btrfs_delayed_ref_head *head_ref,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int action),<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_ARGS(fs_info, head_ref, action)<br>
);<br>
<br>
DEFINE_EVENT(btrfs_delayed_ref<wbr>_head,=C2=A0 run_delayed_ref_head,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_PROTO(const struct btrfs_fs_info *fs_info,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct =
btrfs_delayed_ref_head *head_ref,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int action),<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_ARGS(fs_info, head_ref, action)<br>
);<br>
<br>
It appears that this instrumentation has not been hooked on any actual<br>
tracepoint for quite some time in lttng-modules.<br>
<br>
We should adapt the lttng-modules instrumentation accordingly. I would<br>
not be surprised that the 4.8.0 kernel version range is also incorrect:<br>
it should apply to the &quot;new&quot; events based on the tracepoint class=
.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt;<br>
&gt; Signed-off-by: Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios=
.com" target=3D"_blank">mjeanson@efficios.com</a>&gt;<br>
&gt; ---<br>
&gt; instrumentation/events/lttng-m<wbr>odule/btrfs.h | 18 ++++++++++++++++=
+-<br>
&gt; 1 file changed, 17 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/instrumentation/events/lttng<wbr>-module/btrfs.h<br>
&gt; b/instrumentation/events/lttng<wbr>-module/btrfs.h<br>
&gt; index b529e8e..7901f05 100644<br>
&gt; --- a/instrumentation/events/lttng<wbr>-module/btrfs.h<br>
&gt; +++ b/instrumentation/events/lttng<wbr>-module/btrfs.h<br>
&gt; @@ -680,7 +680,23 @@ LTTNG_TRACEPOINT_EVENT(btrfs_d<wbr>elayed_data_re=
f,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
&gt; )<br>
&gt;<br>
&gt; -#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(4,8,0))<br>
&gt; +#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(4,15,0))<br>
&gt; +LTTNG_TRACEPOINT_EVENT(btrfs_<wbr>delayed_ref_head,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TP_PROTO(struct btrfs_fs_info *fs_info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct btrfs_delayed=
_ref_head *head_ref,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int action),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TP_ARGS(fs_info, head_ref, action),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TP_FIELDS(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(u64, byte=
nr, head_ref-&gt;bytenr)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(u64, num_=
bytes, head_ref-&gt;num_bytes)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(int, acti=
on, action)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer(int, is_d=
ata, head_ref-&gt;is_data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0)<br>
&gt; +)<br>
&gt; +#elif (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(4,8,0))<br>
&gt; LTTNG_TRACEPOINT_EVENT(btrfs_d<wbr>elayed_ref_head,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_PROTO(struct btrfs_fs_info *fs_info,<br>
&gt; --<br>
&gt; 2.7.4<br>
<br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
<br>
<br>
------------------------------<br>
<br>
End of lttng-dev Digest, Vol 117, Issue 3<br>
******************************<wbr>***********<br>
</blockquote></div><br></div></div>

--94eb2c14070260bb3105625fc2c8--

--===============2898309727610786990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2898309727610786990==--
