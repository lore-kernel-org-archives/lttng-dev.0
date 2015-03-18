From: Chidhu R <chid1989@gmail.com>
Subject: Unable to make lttng run for multiple instances in
	parallel
Date: Wed, 18 Mar 2015 09:30:10 -0700
Message-ID: <CAL1ZhON-ZwP_C6VvzPv9Jj530fRRVdevuCk+zAq9zVM-enApiA__20317.2644520693$1426696327$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0212283546=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f49.google.com ([209.85.215.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1YYGrx-0005tZ-0Y
 for lttng-dev@lists.lttng.org; Wed, 18 Mar 2015 12:30:59 -0400
Received: by lamx15 with SMTP id x15so40716291lam.3
 for <lttng-dev@lists.lttng.org>; Wed, 18 Mar 2015 09:30:51 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0212283546==
Content-Type: multipart/alternative; boundary=001a11c2a87a400bc40511929b30

--001a11c2a87a400bc40511929b30
Content-Type: text/plain; charset=UTF-8

Hello,

When I try to execute the following code, I always run into errors. Can
someone help me.

Code:

int lttng_init() {
        int err;
        int l_fd = -1;

        if(0 != system("mkdir /tmp/mk_lttng")) {
                printf("Directory exists\n");
        }

        setenv("LTTNG_HOME", "/tmp/mk_lttng", 1);
        fprintf(stderr, "LTTNG_HOME is %s\n",getenv("LTTNG_HOME"));

        l_fd = open("/tmp/lttng_test.lck", O_CREAT | O_WRONLY | O_EXCL,
0644);
        err = errno;

        if(l_fd != -1) {
                fprintf(stderr, "Creating lock file l_fd = %d\n", l_fd);
                if(0 != system("lttng destroy -a")) {
                        return -1;
                }

                if(0 != system("lttng create")) {
                        return -1;
                }

                if(0 != system("lttng enable-event -u -a")) {
                        return -1;
                }

                if(0 != system("lttng start")) {
                        return -1;
                }

        }
        else {
                fprintf(stderr, "Unable to get lock err = %d\n",err);
                // Someone has already created a session. We just dump into
their buffer
        }
}


int main() {
        if( -1 == lttng_init())
            assert(0);
}

When I compile and run the above code, I am getting these errors.

cycl01:~/hello-tp% ./hello
mkdir: cannot create directory `/tmp/mk_lttng': File exists
Directory exists
LTTNG_HOME is /tmp/mk_lttng
Creating lock file l_fd = 4
Spawning a session daemon
I/O warning : failed to load external entity
"/usr/share/xml/lttng/session.xsd"
XML Error: Failed to locate the main schema resource at
'/usr/share/xml/lttng/session.xsd'.
Error: XSD parsing failed
Error: Session load failed: Invalid session configuration
No session found, nothing to do.
*PERROR - 09:20:36.889067 [7142/7150]: bind inet: Address already in use
(in lttcomm_bind_inet_sock() at inet.c:109)*
*Warning: Another session daemon is using this JUL port. JUL support will
be deactivated to prevent interfering with the tracing. *

*I am trying to run multiple of these programs in parallel*. So I am trying
to incorporate a locking mechanism so that only one instance succeeds and
creates the session, and other instances just dump into the existing
session.

Thanks
Chid

--001a11c2a87a400bc40511929b30
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>When I try to execute the follow=
ing code, I always run into errors. Can someone help me.</div><div><br></di=
v><div>Code:</div><div><br></div><div><div>int lttng_init() {</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int err;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int=
 l_fd =3D -1;</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if(0 !=
=3D system(&quot;mkdir /tmp/mk_lttng&quot;)) {</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Directory exists\n&quot=
;);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div><br></div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 setenv(&quot;LTTNG_HOME&quot;, &quot;/tmp/mk_lttng&qu=
ot;, 1);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;LTTNG_=
HOME is %s\n&quot;,getenv(&quot;LTTNG_HOME&quot;));</div><div><br></div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 l_fd =3D open(&quot;/tmp/lttng_test.lck&quot;=
, O_CREAT | O_WRONLY | O_EXCL, 0644);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 err =3D errno;</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if(l_f=
d !=3D -1) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 fprintf(stderr, &quot;Creating lock file l_fd =3D %d\n&quot;, l_fd);</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if(0 !=3D s=
ystem(&quot;lttng destroy -a&quot;)) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div><=
br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if(0 =
!=3D system(&quot;lttng create&quot;)) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div><=
br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if(0 =
!=3D system(&quot;lttng enable-event -u -a&quot;)) {</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn -1;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if(0 !=3D system(&quot;lttng start&quot;)) {</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Unable to get lock err =
=3D %d\n&quot;,err);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 // Someone has already created a session. We just dump into t=
heir buffer</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>}</div></div>=
<div><br></div><div><br></div><div>int main() {</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if( -1 =3D=3D lttng_init())</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 assert(0);</div><div>}</div><div><br></div><div>When I co=
mpile and run the above code, I am getting these errors.</div><div><br></di=
v><div><div>cycl01:~/hello-tp% ./hello</div><div>mkdir: cannot create direc=
tory `/tmp/mk_lttng&#39;: File exists</div><div>Directory exists</div><div>=
LTTNG_HOME is /tmp/mk_lttng</div><div>Creating lock file l_fd =3D 4</div><d=
iv>Spawning a session daemon</div><div>I/O warning : failed to load externa=
l entity &quot;/usr/share/xml/lttng/session.xsd&quot;</div><div>XML Error: =
Failed to locate the main schema resource at &#39;/usr/share/xml/lttng/sess=
ion.xsd&#39;.</div><div>Error: XSD parsing failed</div><div>Error: Session =
load failed: Invalid session configuration</div><div>No session found, noth=
ing to do.</div><div><b>PERROR - 09:20:36.889067 [7142/7150]: bind inet: Ad=
dress already in use (in lttcomm_bind_inet_sock() at inet.c:109)</b></div><=
div><b>Warning: Another session daemon is using this JUL port. JUL support =
will be deactivated to prevent interfering with the tracing.=C2=A0</b></div=
></div><div><b><br></b></div><div><b>I am trying to run multiple of these p=
rograms in parallel</b>. So I am trying to incorporate a locking mechanism =
so that only one instance succeeds and creates the session, and other insta=
nces just dump into the existing session.=C2=A0</div><div><br></div><div>Th=
anks</div><div>Chid</div></div>

--001a11c2a87a400bc40511929b30--


--===============0212283546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0212283546==--
