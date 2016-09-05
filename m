From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH 0/6] hypertrace: Lightweight guest-to-QEMU
 trace channel
Date: Mon, 5 Sep 2016 15:59:16 +0100
Message-ID: <20160905145916.GI24656@redhat.com>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
	<20160818105424.GD4850@stefanha-x1.localdomain>
	<8737lypajh.fsf@fimbulvetr.bsc.es>
	<20160823155430.GB3948@stefanha-x1.localdomain>
	<87lgzm4g5p.fsf@fimbulvetr.bsc.es>
	<20160829134502.GA26282@stefanha-x1.localdomain>
	<87a8fvjtw5.fsf@fimbulvetr.bsc.es>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <87a8fvjtw5.fsf@fimbulvetr.bsc.es>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Aug 29, 2016 at 08:46:02PM +0200, Llu=C3=ADs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
> > When SystemTap is used the QEMU monitor interface does nothing.
>=20
> That's not what I've experienced. I was able to use a stap script to ch=
ange the
> tracing state of events:
>=20
>    #!/usr/bin/env stap
>=20
>    %{
>    #include </home/lluis/Projects/qemu-dbi-test/test.h>
>    %}
>=20
>    function event:long(cpu:long, addr:long, info:long)
>    %{
>        char *argv[4] =3D {"/bin/sh", "-c", "echo 'trace-event * off' | =
telnet localhost 1234", NULL};
>        call_usermodehelper(argv[0], argv, NULL, UMH_WAIT_EXEC);
>        STAP_RETURN(0);
>    %}

I don't know what you're trying to achieve here.  The trace-event state,
as changed/viewed via QEMU monitor, is irrelevant to the dtrace (systemta=
p)
backend. dtrace and ltt-ust are both fully dynamic trace event backends,
so the QEMU event state has no effect on them. The probe points in the
binary are dynamically enabled / disabled by the dtrace runtime. ie dtrac=
e
will automatically enable an event if you write a dtrace script that uses
the event.


Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr=
/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vn=
c :|
