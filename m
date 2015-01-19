From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Sequence of strings
Date: Mon, 19 Jan 2015 17:50:07 -0500
Message-ID: <CAC6yHM74MO8UN7d8B2WLj0EM8mZuhJLiaudGoSMDmNDOSwDa3A__7902.96785203299$1421707918$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0031572708=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1YDL9C-0006Dd-2T
 for lttng-dev@lists.lttng.org; Mon, 19 Jan 2015 17:50:16 -0500
Received: by mail-qc0-f179.google.com with SMTP id w7so7997555qcr.10
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jan 2015 14:50:08 -0800 (PST)
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

--===============0031572708==
Content-Type: multipart/alternative; boundary=001a11c04006ddc083050d0924af

--001a11c04006ddc083050d0924af
Content-Type: text/plain; charset=UTF-8

Hi,

I would like to record a sequence of strings. Here is an example:

struct foo {
  string _my_string;
};

event {
  ...
  fields := struct {
    uint8_t _num;
    struct foo _items[_num];
  };
};

The program barectf does not allow it, and I wanted to know whether it's an
implementation limitation or if CTF supports it at all.

Thanks,

Francis

--001a11c04006ddc083050d0924af
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I would like to record a sequence o=
f strings. Here is an example:</div><div><br></div><div><div>struct foo {</=
div><div>=C2=A0 string _my_string;</div><div>};=C2=A0</div></div><div><br><=
/div><div>event {</div><div>=C2=A0 ...</div><div>=C2=A0 fields :=3D struct =
{</div><div>=C2=A0 =C2=A0 uint8_t _num;</div><div>=C2=A0 =C2=A0 struct foo =
_items[_num];</div><div>=C2=A0 };</div><div>};</div><div><br></div><div>The=
 program barectf does not allow it, and I wanted to know whether it&#39;s a=
n implementation limitation or if CTF supports it at all.</div><div><br></d=
iv><div>Thanks,</div><div><br></div><div>Francis</div></div>

--001a11c04006ddc083050d0924af--


--===============0031572708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0031572708==--
