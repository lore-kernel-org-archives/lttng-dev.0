From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [RFC Patch Tools 3/4] Remove required parameter
 from module parameters
Date: Wed, 14 May 2014 14:54:11 +0200
Message-ID: <CAEiAFz0hwuNppkN7tMwKOMBjE03MOxTaYhJiQNp70FXQTY_czw__48637.0589620948$1400072130$gmane$org@mail.gmail.com>
References: <cover.1396521858.git.jan.glauber@gmail.com>
 <5a25b2f118fe3069a12e292b380031364f3e9a68.1396521858.git.jan.glauber@gmail.com>
 <20140513174750.GH7414@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1040685172=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WkYhN-00048R-0E
 for lttng-dev@lists.lttng.org; Wed, 14 May 2014 08:54:23 -0400
Received: by mail-qg0-f45.google.com with SMTP id z60so2700796qgd.32
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2014 05:54:11 -0700 (PDT)
In-Reply-To: <20140513174750.GH7414@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1040685172==
Content-Type: multipart/alternative; boundary=001a11346b544926dc04f95bada8

--001a11346b544926dc04f95bada8
Content-Type: text/plain; charset=UTF-8

Hi David,
OK, I'll rebase onto upstream master and resend the whole series.


thanks, Jan


2014-05-13 19:47 GMT+02:00 David Goulet <dgoulet@efficios.com>:

> Hi Jan,
>
> I was merging those for 2.5 but this one (3/4) does not apply. I tried
> to play with it but I can't make it work.
>
> The only thing that has changed is that we've added a module lately but
> even by modifying your patch to add that module, it still does not
> apply.
>
> Do you think you can simply rebase those on upstream master and send it
> back to me? (You can also send me a branch, I'm fine with emails or
> branch).
>
> Big thanks!
> David
>
> On 03 Apr (12:57:46), Jan Glauber wrote:
> > Remove the per module required parameter by adding another list
> > for optional core modules, so we have:
> >
> > - required core modules
> > - optional core modules
> > - optional probe modules
> >
> > Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
> > ---
> >  src/bin/lttng-sessiond/kern-modules.h |    1 -
> >  src/bin/lttng-sessiond/modprobe.c     |  167
> ++++++++++++++++++---------------
> >  2 files changed, 92 insertions(+), 76 deletions(-)
> >
> > diff --git a/src/bin/lttng-sessiond/kern-modules.h
> b/src/bin/lttng-sessiond/kern-modules.h
> > index 7ce8b0b..ca09fc3 100644
> > --- a/src/bin/lttng-sessiond/kern-modules.h
> > +++ b/src/bin/lttng-sessiond/kern-modules.h
> > @@ -29,7 +29,6 @@
> >
> >  struct kern_modules_param {
> >       const char *name;
> > -     int required;
> >  };
> >
> >  #endif /* _KERN_MODULES_H */
> > diff --git a/src/bin/lttng-sessiond/modprobe.c
> b/src/bin/lttng-sessiond/modprobe.c
> > index ea3fb39..79a01ea 100644
> > --- a/src/bin/lttng-sessiond/modprobe.c
> > +++ b/src/bin/lttng-sessiond/modprobe.c
> > @@ -25,65 +25,72 @@
> >  #include "modprobe.h"
> >  #include "kern-modules.h"
> >
> > -/* LTTng kernel tracer base modules list */
> > -const struct kern_modules_param kern_modules_control[] = {
> > -     { "lttng-tracer", 1 },  /* MUST be loaded first so keep at top */
> > -     { "lttng-lib-ring-buffer", 1 },
> > -     { "lttng-ring-buffer-client-discard", 1 },
> > -     { "lttng-ring-buffer-client-overwrite", 1 },
> > -     { "lttng-ring-buffer-metadata-client", 1 },
> > -     { "lttng-ring-buffer-client-mmap-discard", 1 },
> > -     { "lttng-ring-buffer-client-mmap-overwrite", 1 },
> > -     { "lttng-ring-buffer-metadata-mmap-client", 1 },
> > -     { "lttng-types", 0 },
> > -     { "lttng-ftrace", 0 },
> > -     { "lttng-kprobes", 0 },
> > -     { "lttng-kretprobes", 0 },
> > +#define LTTNG_MOD_REQUIRED   1
> > +#define LTTNG_MOD_OPTIONAL   0
> > +
> > +/* LTTng kernel tracer mandatory core modules list */
> > +const struct kern_modules_param kern_modules_control_core[] = {
> > +     { "lttng-tracer" },     /* MUST be loaded first so keep at top */
> > +     { "lttng-lib-ring-buffer" },
> > +     { "lttng-ring-buffer-client-discard" },
> > +     { "lttng-ring-buffer-client-overwrite" },
> > +     { "lttng-ring-buffer-metadata-client" },
> > +     { "lttng-ring-buffer-client-mmap-discard" },
> > +     { "lttng-ring-buffer-client-mmap-overwrite" },
> > +     { "lttng-ring-buffer-metadata-mmap-client" },
> > +};
> > +
> > +/* LTTng kernel tracer optional base modules list */
> > +const struct kern_modules_param kern_modules_control_opt[] = {
> > +     { "lttng-types" },
> > +     { "lttng-ftrace" },
> > +     { "lttng-kprobes" },
> > +     { "lttng-kretprobes" },
> >  };
> >
> >  /* LTTng kernel tracer probe modules list */
> >  const struct kern_modules_param kern_modules_probes[] = {
> > -     { "lttng-probe-asoc", 0 },
> > -     { "lttng-probe-block", 0 },
> > -     { "lttng-probe-btrfs", 0 },
> > -     { "lttng-probe-compaction", 0 },
> > -     { "lttng-probe-ext3", 0 },
> > -     { "lttng-probe-ext4", 0 },
> > -     { "lttng-probe-gpio", 0 },
> > -     { "lttng-probe-irq", 0 },
> > -     { "lttng-probe-jbd", 0 },
> > -     { "lttng-probe-jbd2", 0 },
> > -     { "lttng-probe-kmem", 0 },
> > -     { "lttng-probe-kvm", 0 },
> > -     { "lttng-probe-kvm-x86", 0 },
> > -     { "lttng-probe-kvm-x86-mmu", 0 },
> > -     { "lttng-probe-lock", 0 },
> > -     { "lttng-probe-module", 0 },
> > -     { "lttng-probe-napi", 0 },
> > -     { "lttng-probe-net", 0 },
> > -     { "lttng-probe-power", 0 },
> > -     { "lttng-probe-printk", 0 },
> > -     { "lttng-probe-random", 0 },
> > -     { "lttng-probe-rcu", 0 },
> > -     { "lttng-probe-regmap", 0 },
> > -     { "lttng-probe-regulator", 0 },
> > -     { "lttng-probe-rpm", 0 },
> > -     { "lttng-probe-sched", 0 },
> > -     { "lttng-probe-scsi", 0 },
> > -     { "lttng-probe-signal", 0 },
> > -     { "lttng-probe-skb", 0 },
> > -     { "lttng-probe-sock", 0 },
> > -     { "lttng-probe-statedump", 0 },
> > -     { "lttng-probe-sunrpc", 0 },
> > -     { "lttng-probe-timer", 0 },
> > -     { "lttng-probe-udp", 0 },
> > -     { "lttng-probe-vmscan", 0 },
> > -     { "lttng-probe-workqueue", 0 },
> > -     { "lttng-probe-writeback", 0 },
> > +     { "lttng-probe-asoc" },
> > +     { "lttng-probe-block" },
> > +     { "lttng-probe-btrfs" },
> > +     { "lttng-probe-compaction" },
> > +     { "lttng-probe-ext3" },
> > +     { "lttng-probe-ext4" },
> > +     { "lttng-probe-gpio" },
> > +     { "lttng-probe-irq" },
> > +     { "lttng-probe-jbd" },
> > +     { "lttng-probe-jbd2" },
> > +     { "lttng-probe-kmem" },
> > +     { "lttng-probe-kvm" },
> > +     { "lttng-probe-kvm-x86" },
> > +     { "lttng-probe-kvm-x86-mmu" },
> > +     { "lttng-probe-lock" },
> > +     { "lttng-probe-module" },
> > +     { "lttng-probe-napi" },
> > +     { "lttng-probe-net" },
> > +     { "lttng-probe-power" },
> > +     { "lttng-probe-printk" },
> > +     { "lttng-probe-random" },
> > +     { "lttng-probe-rcu" },
> > +     { "lttng-probe-regmap" },
> > +     { "lttng-probe-regulator" },
> > +     { "lttng-probe-rpm" },
> > +     { "lttng-probe-sched" },
> > +     { "lttng-probe-scsi" },
> > +     { "lttng-probe-signal" },
> > +     { "lttng-probe-skb" },
> > +     { "lttng-probe-sock" },
> > +     { "lttng-probe-statedump" },
> > +     { "lttng-probe-sunrpc" },
> > +     { "lttng-probe-timer" },
> > +     { "lttng-probe-udp" },
> > +     { "lttng-probe-vmscan" },
> > +     { "lttng-probe-workqueue" },
> > +     { "lttng-probe-writeback" },
> >  };
> >
> >  void modprobe_remove_lttng(const struct kern_modules_param *modules,
> > -                        int entries)
> > +                        int entries, int required)
> >  {
> >       int ret = 0, i;
> >       char modprobe[256];
> > @@ -94,26 +101,21 @@ void modprobe_remove_lttng(const struct
> kern_modules_param *modules,
> >                               modules[i].name);
> >               if (ret < 0) {
> >                       PERROR("snprintf modprobe -r");
> > -                     goto error;
> > +                     return;
> >               }
> >               modprobe[sizeof(modprobe) - 1] = '\0';
> >               ret = system(modprobe);
> >               if (ret == -1) {
> >                       ERR("Unable to launch modprobe -r for module %s",
> > -                                     kern_modules_control[i].name);
> > -             } else if (kern_modules_control[i].required
> > -                             && WEXITSTATUS(ret) != 0) {
> > +                                     modules[i].name);
> > +             } else if (required && WEXITSTATUS(ret) != 0) {
> >                       ERR("Unable to remove module %s",
> > -                                     kern_modules_control[i].name);
> > +                                     modules[i].name);
> >               } else {
> >                       DBG("Modprobe removal successful %s",
> > -                                     kern_modules_control[i].name);
> > +                                     modules[i].name);
> >               }
> >       }
> > -
> > -error:
> > -     return;
> > -
> >  }
> >
> >  /*
> > @@ -121,8 +123,12 @@ error:
> >   */
> >  void modprobe_remove_lttng_control(void)
> >  {
> > -     return modprobe_remove_lttng(kern_modules_control,
> > -                                  ARRAY_SIZE(kern_modules_control));
> > +     modprobe_remove_lttng(kern_modules_control_opt,
> > +                                 ARRAY_SIZE(kern_modules_control_opt),
> > +                                 LTTNG_MOD_OPTIONAL);
> > +     modprobe_remove_lttng(kern_modules_control_core,
> > +                                  ARRAY_SIZE(kern_modules_control_core),
> > +                                  LTTNG_MOD_REQUIRED);
> >  }
> >
> >  /*
> > @@ -131,7 +137,8 @@ void modprobe_remove_lttng_control(void)
> >  void modprobe_remove_lttng_data(void)
> >  {
> >       return modprobe_remove_lttng(kern_modules_probes,
> > -                                  ARRAY_SIZE(kern_modules_list));
> > +                                  ARRAY_SIZE(kern_modules_probes),
> > +                                  LTTNG_MOD_OPTIONAL);
> >  }
> >
> >  /*
> > @@ -143,7 +150,8 @@ void modprobe_remove_lttng_all(void)
> >       modprobe_remove_lttng_control();
> >  }
> >
> > -static int modprobe_lttng(const struct kern_modules_param *modules, int
> entries)
> > +static int modprobe_lttng(const struct kern_modules_param *modules,
> > +                       int entries, int required)
> >  {
> >       int ret = 0, i;
> >       char modprobe[256];
> > @@ -151,7 +159,7 @@ static int modprobe_lttng(const struct
> kern_modules_param *modules, int entries)
> >       for (i = 0; i < entries; i++) {
> >               ret = snprintf(modprobe, sizeof(modprobe),
> >                               "/sbin/modprobe %s%s",
> > -                             modules[i].required ? "" : "-q ",
> > +                             required ? "" : "-q ",
> >                               modules[i].name);
> >               if (ret < 0) {
> >                       PERROR("snprintf modprobe");
> > @@ -162,12 +170,10 @@ static int modprobe_lttng(const struct
> kern_modules_param *modules, int entries)
> >               if (ret == -1) {
> >                       ERR("Unable to launch modprobe for module %s",
> >                                       modules[i].name);
> > -             } else if (modules[i].required && WEXITSTATUS(ret) != 0) {
> > -                     ERR("Unable to load module %s",
> > -                                     modules[i].name);
> > +             } else if (required && WEXITSTATUS(ret) != 0) {
> > +                     ERR("Unable to load module %s", modules[i].name);
> >               } else {
> > -                     DBG("Modprobe successfully %s",
> > -                                     modules[i].name);
> > +                     DBG("Modprobe successfully %s", modules[i].name);
> >               }
> >       }
> >
> > @@ -180,14 +186,25 @@ error:
> >   */
> >  int modprobe_lttng_control(void)
> >  {
> > -     return modprobe_lttng(kern_modules_control,
> > -                           ARRAY_SIZE(kern_modules_control));
> > +     int ret;
> > +
> > +     ret = modprobe_lttng(kern_modules_control_core,
> > +                          ARRAY_SIZE(kern_modules_control_core),
> > +                          LTTNG_MOD_REQUIRED);
> > +     if (ret != 0)
> > +             return ret;
> > +     ret = modprobe_lttng(kern_modules_control_opt,
> > +                           ARRAY_SIZE(kern_modules_control_opt),
> > +                           LTTNG_MOD_OPTIONAL);
> > +     return ret;
> >  }
> > +
> >  /*
> >   * Load data kernel module(s).
> >   */
> >  int modprobe_lttng_data(void)
> >  {
> >       return modprobe_lttng(kern_modules_probes,
> > -                           ARRAY_SIZE(kern_modules_probes));
> > +                           ARRAY_SIZE(kern_modules_probes),
> > +                           LTTNG_MOD_OPTIONAL);
> >  }
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--001a11346b544926dc04f95bada8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi David,<br></div>OK, I&#39;ll rebase onto upst=
ream master and resend the whole series.<br><br><br></div>thanks, Jan<br></=
div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2014-05-1=
3 19:47 GMT+02:00 David Goulet <span dir=3D"ltr">&lt;<a href=3D"mailto:dgou=
let@efficios.com" target=3D"_blank">dgoulet@efficios.com</a>&gt;</span>:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Jan,<br>
<br>
I was merging those for 2.5 but this one (3/4) does not apply. I tried<br>
to play with it but I can&#39;t make it work.<br>
<br>
The only thing that has changed is that we&#39;ve added a module lately but=
<br>
even by modifying your patch to add that module, it still does not<br>
apply.<br>
<br>
Do you think you can simply rebase those on upstream master and send it<br>
back to me? (You can also send me a branch, I&#39;m fine with emails or<br>
branch).<br>
<br>
Big thanks!<br>
David<br>
<div><div class=3D"h5"><br>
On 03 Apr (12:57:46), Jan Glauber wrote:<br>
&gt; Remove the per module required parameter by adding another list<br>
&gt; for optional core modules, so we have:<br>
&gt;<br>
&gt; - required core modules<br>
&gt; - optional core modules<br>
&gt; - optional probe modules<br>
&gt;<br>
&gt; Signed-off-by: Jan Glauber &lt;<a href=3D"mailto:jan.glauber@gmail.com=
">jan.glauber@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0src/bin/lttng-sessiond/kern-modules.h | =C2=A0 =C2=A01 -<br>
&gt; =C2=A0src/bin/lttng-sessiond/modprobe.c =C2=A0 =C2=A0 | =C2=A0167 ++++=
++++++++++++++---------------<br>
&gt; =C2=A02 files changed, 92 insertions(+), 76 deletions(-)<br>
&gt;<br>
&gt; diff --git a/src/bin/lttng-sessiond/kern-modules.h b/src/bin/lttng-ses=
siond/kern-modules.h<br>
&gt; index 7ce8b0b..ca09fc3 100644<br>
&gt; --- a/src/bin/lttng-sessiond/kern-modules.h<br>
&gt; +++ b/src/bin/lttng-sessiond/kern-modules.h<br>
&gt; @@ -29,7 +29,6 @@<br>
&gt;<br>
&gt; =C2=A0struct kern_modules_param {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 const char *name;<br>
&gt; - =C2=A0 =C2=A0 int required;<br>
&gt; =C2=A0};<br>
&gt;<br>
&gt; =C2=A0#endif /* _KERN_MODULES_H */<br>
&gt; diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-session=
d/modprobe.c<br>
&gt; index ea3fb39..79a01ea 100644<br>
&gt; --- a/src/bin/lttng-sessiond/modprobe.c<br>
&gt; +++ b/src/bin/lttng-sessiond/modprobe.c<br>
&gt; @@ -25,65 +25,72 @@<br>
&gt; =C2=A0#include &quot;modprobe.h&quot;<br>
&gt; =C2=A0#include &quot;kern-modules.h&quot;<br>
&gt;<br>
&gt; -/* LTTng kernel tracer base modules list */<br>
&gt; -const struct kern_modules_param kern_modules_control[] =3D {<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-tracer&quot;, 1 }, =C2=A0/* MUST be load=
ed first so keep at top */<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-lib-ring-buffer&quot;, 1 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-client-discard&quot;, 1 },<b=
r>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-client-overwrite&quot;, 1 },=
<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-metadata-client&quot;, 1 },<=
br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-client-mmap-discard&quot;, 1=
 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-client-mmap-overwrite&quot;,=
 1 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-metadata-mmap-client&quot;, =
1 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-types&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-ftrace&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-kprobes&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-kretprobes&quot;, 0 },<br>
&gt; +#define LTTNG_MOD_REQUIRED =C2=A0 1<br>
&gt; +#define LTTNG_MOD_OPTIONAL =C2=A0 0<br>
&gt; +<br>
&gt; +/* LTTng kernel tracer mandatory core modules list */<br>
&gt; +const struct kern_modules_param kern_modules_control_core[] =3D {<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-tracer&quot; }, =C2=A0 =C2=A0 /* MUST be=
 loaded first so keep at top */<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-lib-ring-buffer&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-client-discard&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-client-overwrite&quot; },<br=
>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-metadata-client&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-client-mmap-discard&quot; },=
<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-client-mmap-overwrite&quot; =
},<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-ring-buffer-metadata-mmap-client&quot; }=
,<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* LTTng kernel tracer optional base modules list */<br>
&gt; +const struct kern_modules_param kern_modules_control_opt[] =3D {<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-types&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-ftrace&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-kprobes&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-kretprobes&quot; },<br>
&gt; =C2=A0};<br>
&gt;<br>
&gt; =C2=A0/* LTTng kernel tracer probe modules list */<br>
&gt; =C2=A0const struct kern_modules_param kern_modules_probes[] =3D {<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-asoc&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-block&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-btrfs&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-compaction&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-ext3&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-ext4&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-gpio&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-irq&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-jbd&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-jbd2&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-kmem&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-kvm&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-kvm-x86&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-kvm-x86-mmu&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-lock&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-module&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-napi&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-net&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-power&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-printk&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-random&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-rcu&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-regmap&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-regulator&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-rpm&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-sched&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-scsi&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-signal&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-skb&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-sock&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-statedump&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-sunrpc&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-timer&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-udp&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-vmscan&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-workqueue&quot;, 0 },<br>
&gt; - =C2=A0 =C2=A0 { &quot;lttng-probe-writeback&quot;, 0 },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-asoc&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-block&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-btrfs&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-compaction&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-ext3&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-ext4&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-gpio&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-irq&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-jbd&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-jbd2&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-kmem&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-kvm&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-kvm-x86&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-kvm-x86-mmu&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-lock&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-module&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-napi&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-net&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-power&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-printk&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-random&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-rcu&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-regmap&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-regulator&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-rpm&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-sched&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-scsi&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-signal&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-skb&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-sock&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-statedump&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-sunrpc&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-timer&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-udp&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-vmscan&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-workqueue&quot; },<br>
&gt; + =C2=A0 =C2=A0 { &quot;lttng-probe-writeback&quot; },<br>
&gt; =C2=A0};<br>
&gt;<br>
&gt; =C2=A0void modprobe_remove_lttng(const struct kern_modules_param *modu=
les,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int entries)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int entries, int required)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 int ret =3D 0, i;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 char modprobe[256];<br>
&gt; @@ -94,26 +101,21 @@ void modprobe_remove_lttng(const struct kern_modu=
les_param *modules,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules[i].name);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PERROR(&quot;snprintf modprobe -r&quot;);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto error;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modprobe[sizeof(modpr=
obe) - 1] =3D &#39;\0&#39;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D system(modpro=
be);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -1) {<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ERR(&quot;Unable to launch modprobe -r for module %s&quot;,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kern_modules_co=
ntrol[i].name);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (kern_modules_co=
ntrol[i].required<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; WEXITSTATUS(ret) !=3D 0) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules[i].name=
);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (required &amp;&=
amp; WEXITSTATUS(ret) !=3D 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ERR(&quot;Unable to remove module %s&quot;,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kern_modules_co=
ntrol[i].name);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules[i].name=
);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBG(&quot;Modprobe removal successful %s&quot;,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kern_modules_co=
ntrol[i].name);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules[i].name=
);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -error:<br>
&gt; - =C2=A0 =C2=A0 return;<br>
&gt; -<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0/*<br>
&gt; @@ -121,8 +123,12 @@ error:<br>
&gt; =C2=A0 */<br>
&gt; =C2=A0void modprobe_remove_lttng_control(void)<br>
&gt; =C2=A0{<br>
&gt; - =C2=A0 =C2=A0 return modprobe_remove_lttng(kern_modules_control,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(kern_modules=
_control));<br>
&gt; + =C2=A0 =C2=A0 modprobe_remove_lttng(kern_modules_control_opt,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARRAY_SIZE(kern_modules_contr=
ol_opt),<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_MOD_OPTIONAL);<br>
&gt; + =C2=A0 =C2=A0 modprobe_remove_lttng(kern_modules_control_core,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(kern_modules=
_control_core),<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LTTNG_MOD_REQUIRED);<br=
>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0/*<br>
&gt; @@ -131,7 +137,8 @@ void modprobe_remove_lttng_control(void)<br>
&gt; =C2=A0void modprobe_remove_lttng_data(void)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 return modprobe_remove_lttng(kern_modules_probes,=
<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(kern_modules=
_list));<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(kern_modules=
_probes),<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LTTNG_MOD_OPTIONAL);<br=
>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0/*<br>
&gt; @@ -143,7 +150,8 @@ void modprobe_remove_lttng_all(void)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 modprobe_remove_lttng_control();<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; -static int modprobe_lttng(const struct kern_modules_param *modules, i=
nt entries)<br>
&gt; +static int modprobe_lttng(const struct kern_modules_param *modules,<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int entries, int required)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 int ret =3D 0, i;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 char modprobe[256];<br>
&gt; @@ -151,7 +159,7 @@ static int modprobe_lttng(const struct kern_module=
s_param *modules, int entries)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; entries; i++) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D snprintf(modp=
robe, sizeof(modprobe),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;/sbin/modprobe %s%s&quot;,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules[i].required ? &quot;&quot; : &quot;=
-q &quot;,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required ? &quot;&quot; : &quot;-q &quot;,<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules[i].name);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PERROR(&quot;snprintf modprobe&quot;);<br>
&gt; @@ -162,12 +170,10 @@ static int modprobe_lttng(const struct kern_modu=
les_param *modules, int entries)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -1) {<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ERR(&quot;Unable to launch modprobe for module %s&quot;,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules[i].n=
ame);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (modules[i].requ=
ired &amp;&amp; WEXITSTATUS(ret) !=3D 0) {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ERR(&quot;Unable to load module %s&quot;,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules[i].name=
);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (required &amp;&=
amp; WEXITSTATUS(ret) !=3D 0) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ERR(&quot;Unable to load module %s&quot;, modules[i].name);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DBG(&quot;Modprobe successfully %s&quot;,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules[i].name=
);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DBG(&quot;Modprobe successfully %s&quot;, modules[i].name);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; @@ -180,14 +186,25 @@ error:<br>
&gt; =C2=A0 */<br>
&gt; =C2=A0int modprobe_lttng_control(void)<br>
&gt; =C2=A0{<br>
&gt; - =C2=A0 =C2=A0 return modprobe_lttng(kern_modules_control,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ARRAY_SIZE(kern_modules_control));<br>
&gt; + =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 ret =3D modprobe_lttng(kern_modules_control_core,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(kern_modules_control_core),<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0LTTNG_MOD_REQUIRED);<br>
&gt; + =C2=A0 =C2=A0 if (ret !=3D 0)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; + =C2=A0 =C2=A0 ret =3D modprobe_lttng(kern_modules_control_opt,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ARRAY_SIZE(kern_modules_control_opt),<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_MOD_OPTIONAL);<br>
&gt; + =C2=A0 =C2=A0 return ret;<br>
&gt; =C2=A0}<br>
&gt; +<br>
&gt; =C2=A0/*<br>
&gt; =C2=A0 * Load data kernel module(s).<br>
&gt; =C2=A0 */<br>
&gt; =C2=A0int modprobe_lttng_data(void)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 return modprobe_lttng(kern_modules_probes,<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ARRAY_SIZE(kern_modules_probes));<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ARRAY_SIZE(kern_modules_probes),<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 LTTNG_MOD_OPTIONAL);<br>
&gt; =C2=A0}<br>
&gt; --<br>
&gt; 1.7.9.5<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
</blockquote></div><br></div>

--001a11346b544926dc04f95bada8--


--===============1040685172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1040685172==--
