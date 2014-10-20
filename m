From: Anand Neeli <anand.neeli@gmail.com>
Subject: relaunch sessiond if relayd gets killed.
Date: Tue, 21 Oct 2014 00:02:34 +0530
Message-ID: <CAM5kDqwpEdCFgF07O5b3qZZvxqY=KvyFOnkr+WWsda2jOdXYTg__16662.5011283488$1413830015$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2056214357=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XgHl2-0005bk-0u
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 14:32:45 -0400
Received: by mail-wg0-f41.google.com with SMTP id b13so6204570wgh.24
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 11:32:34 -0700 (PDT)
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

--===============2056214357==
Content-Type: multipart/alternative; boundary=f46d043bdff8315e820505def08b

--f46d043bdff8315e820505def08b
Content-Type: text/plain; charset=UTF-8

Hi All,
if relayd gets killed i see there is connection reset which happens at
client.
Is there a way to relaunch the sessiond/consumerd on a connection reset?

can some hooks be added or helper application be written to relaunch
sessiond in case exit of relayd or any other connection reset?

Thanks,
Anand Neeli

--f46d043bdff8315e820505def08b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>if relayd gets killed i see there is connectio=
n reset which happens at client.</div><div>Is there a way to relaunch the s=
essiond/consumerd on a connection reset?</div><div><br></div><div>can some =
hooks be added or helper application be written to relaunch sessiond in cas=
e exit of relayd or any other connection reset?</div><div><br></div><div>Th=
anks,</div><div>Anand Neeli</div></div>

--f46d043bdff8315e820505def08b--


--===============2056214357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2056214357==--
