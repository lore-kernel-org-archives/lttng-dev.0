From: Jon Bernard <jbernard@debian.org>
Subject: Re: babeltrace test failures on some architectures
Date: Fri, 13 Jun 2014 11:58:45 -0400
Message-ID: <20140613155845.GA18860__22246.7834748842$1402675167$gmane$org@helmut>
References: <20140604184126.GA26877@helmut>
 <CA+jJMxtn8XiLjT5NVURv5K8kECPPoPs1WF-0zTakJmRW=CO3mg@mail.gmail.com>
 <CAEzWAeLEvv8FbHfwq8=sMeDW49DjO_gKoZ99z1Ff9s+dR6GuJQ@mail.gmail.com>
 <20140609145201.GB25766@helmut>
 <CA+jJMxsuEtk3QdDz1_a0MOBq0To7wB4+QnOW3Rkp0uJZ1eM1gw@mail.gmail.com>
 <20140613035117.GA8741@helmut>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1WvTsR-0002yp-1X
 for lttng-dev@lists.lttng.org; Fri, 13 Jun 2014 11:58:52 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CD1E721129
 for <lttng-dev@lists.lttng.org>; Fri, 13 Jun 2014 11:58:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140613035117.GA8741@helmut>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>, "Brosseau, Yannick" <yannick.brosseau@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Jon Bernard <jbernard@debian.org> wrote:
> * J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com> wrote:
> > The build logs only seem to contain the "prove" output (invoked by run.=
sh).
> > =

> > Could you run tests/bin/test_trace_read and
> > tests/lib/test_seek_empty_packet on armel and sparc? The output of
> > both of these tests and the coredumps (if any) should give me
> > something to work with.
> =

> [...]
> =

> I'll gather the arm results tomorrow.

Well, the armel box to which I have access shows all tests passing :)
I'll have to query the buildd guys for more information and I'll let you
know what I find.

-- =

Jon
