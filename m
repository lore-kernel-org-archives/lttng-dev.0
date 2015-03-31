From: Chidhu R <chid1989@gmail.com>
Subject: Printing complex data types with LTTng
Date: Tue, 31 Mar 2015 09:39:07 -0700
Message-ID: <CAL1ZhONSOm9F8GkQ_z9LSkKwPGzg0C-BROu1AmxtCsZJLnzRzg__21669.1241403625$1427820073$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0233486955=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f54.google.com ([209.85.215.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1YczCj-0007sh-FQ
 for lttng-dev@lists.lttng.org; Tue, 31 Mar 2015 12:39:59 -0400
Received: by labe2 with SMTP id e2so17176043lab.3
 for <lttng-dev@lists.lttng.org>; Tue, 31 Mar 2015 09:39:47 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0233486955==
Content-Type: multipart/alternative; boundary=047d7b3a826029b3920512983f3c

--047d7b3a826029b3920512983f3c
Content-Type: text/plain; charset=UTF-8

Hi,

I wanted to know if there is a way to print complex data types, *given the
pointer* to it.

For ex,

class Msg {
int a;
char *str
};

// Create an object for Msg
// *pass the address of the object* to LTTng and make LTTng print the
values of a and str. I do not want to dereference the pointer and send the
individual values. Or, if there is a function which can be written to
dereference the values and this function could be called each time I pass
the address of the object is also fine.

Is there a way to achieve this with LTTng?

Thanks
Chid

--047d7b3a826029b3920512983f3c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I wanted to know if there is a way =
to print complex data types, <b>given the pointer</b> to it.</div><div><br>=
</div><div>For ex,</div><div><br></div><div>class Msg {</div><div>int a;</d=
iv><div>char *str</div><div>};</div><div><br></div><div>// Create an object=
 for Msg</div><div>// <b>pass the address of the object</b> to LTTng and ma=
ke LTTng print the values of a and str. I do not want to dereference the po=
inter and send the individual values. Or, if there is a function which can =
be written to dereference the values and this function could be called each=
 time I pass the address of the object is also fine.</div><div><br></div><d=
iv>Is there a way to achieve this with LTTng?</div><div><br></div><div>Than=
ks</div><div>Chid</div></div>

--047d7b3a826029b3920512983f3c--


--===============0233486955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0233486955==--
