From: Jon Bernard <jbernard@tuxion.com>
Subject: Re: babeltrace test failures on some architectures
Date: Fri, 13 Jun 2014 11:59:59 -0400
Message-ID: <20140613155959.GB18860__31848.628485068$1402675240$gmane$org@helmut>
References: <20140604184126.GA26877@helmut>
 <CA+jJMxtn8XiLjT5NVURv5K8kECPPoPs1WF-0zTakJmRW=CO3mg@mail.gmail.com>
 <CAEzWAeLEvv8FbHfwq8=sMeDW49DjO_gKoZ99z1Ff9s+dR6GuJQ@mail.gmail.com>
 <20140609145201.GB25766@helmut>
 <CA+jJMxsuEtk3QdDz1_a0MOBq0To7wB4+QnOW3Rkp0uJZ1eM1gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@tuxion.com>) id 1WvTtc-00031i-R2
 for lttng-dev@lists.lttng.org; Fri, 13 Jun 2014 12:00:05 -0400
Content-Disposition: inline
In-Reply-To: <CA+jJMxsuEtk3QdDz1_a0MOBq0To7wB4+QnOW3Rkp0uJZ1eM1gw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com> wrote:
> The build logs only seem to contain the "prove" output (invoked by run.sh=
).
> =

> Could you run tests/bin/test_trace_read and
> tests/lib/test_seek_empty_packet on armel and sparc? The output of
> both of these tests and the coredumps (if any) should give me
> something to work with.

And finally, the hurd build errors (which are clearly the most important :))
are due to missing PATH_MAX.  I'll send a patch for that to the list as
well.

-- =

Jon
