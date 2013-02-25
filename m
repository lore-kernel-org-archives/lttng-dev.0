From: David Smith <dsmith@redhat.com>
Subject: Re: [lttng-dev] Using lttng-ust's libringbuffer outside lttng-ust
Date: Mon, 25 Feb 2013 13:07:06 -0600
Message-ID: <512BB65A.9060604__38824.4417416447$1361823922$gmane$org@redhat.com>
References: <511A9E5A.4010303@redhat.com> <CAGDH53=8kL0oXWZ0Xo73-1EviVbheU0t9fXuzSt05ZCSqVzH_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <systemtap-return-20471-gls-systemtap=m.gmane.org@sourceware.org>
In-Reply-To: <CAGDH53=8kL0oXWZ0Xo73-1EviVbheU0t9fXuzSt05ZCSqVzH_w@mail.gmail.com>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org, systemtap@sourceware.org
List-Id: lttng-dev@lists.lttng.org

On 02/15/2013 02:36 PM, Christian Babeux wrote:
> Hi David,

Thanks for the response.

>> The next question would be what is the best way of using libringbuffer
>> outside lttng-ust. One (not great) possibility would be to just copy the
>> code into systemtap. Of course the problem there is keeping the code up
>> to date with changes in lttng-ust. The next possibility would be to make
>> it a separate project (more like userspace-rcu).
> 
> Splitting libringbuffer from the UST tree right now would prove to be
> quite a challenge. We would need to expose an API to the "clients" of
> the ringbuffer. Currently there are two levels of abstraction that one
> can use with the ringbuffer: a "high-level" one where you use a
> predefined "client" with the associated performance degradation and a
> "low-level" one where you know exactly which kind of "client" you are
> using with the associated fast-path inlined.
> 
> We would need to discuss which level of abstraction we expose to the
> user: a generic one or "N apis" for the different low-level "clients".

In my head, I was planning on using the APIs defined in
libringbuffer/*.h (like lib_ring_buffer_{reserve,commit,write} from
frontend_api.h). But, perhaps we could back up a sec and you could
describe a bit more the low-level vs. high-level levels of abstraction.
Feel free to point me at some code.

-- 
David Smith
dsmith@redhat.com
Red Hat
http://www.redhat.com
256.217.0141 (direct)
256.837.0057 (fax)
