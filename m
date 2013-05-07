From: Yao Qi <yao@codesourcery.com>
Subject: Re: [PATCH 3/5] Read CTF by the ctf target
Date: Tue, 7 May 2013 21:24:34 +0800
Message-ID: <51890092.7020903@codesourcery.com>
References: <1361931459-3953-1-git-send-email-yao@codesourcery.com> <1361931459-3953-4-git-send-email-yao@codesourcery.com> <512F9182.3080104@redhat.com> <CANFwon2TPo1X2cUXXdzDEnX3UPvG2w0ZNMpNGN=KoDdBvyXLFQ@mail.gmail.com> <20130507130741.GE4186@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <gdb-patches-return-101206-gdb-gdb-patches=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:gdb-patches-unsubscribe-##L=##H@sourceware.org>
List-Subscribe: <mailto:gdb-patches-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb-patches/>
List-Post: <mailto:gdb-patches@sourceware.org>
List-Help: <mailto:gdb-patches-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-patches-owner@sourceware.org
In-Reply-To: <20130507130741.GE4186@Krystal>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Hui Zhu <teawater@gmail.com>, gdb-patches@sourceware.org, Pedro Alves <palves@redhat.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 05/07/2013 09:07 PM, Mathieu Desnoyers wrote:
> We did the 1.1.0 release specifically for namespace fixes on March 23rd.
>
> commit c99b1910bea848e8f0ae5641bb63b8f4f84f3ec0
> Author: Mathieu Desnoyers<mathieu.desnoyers@efficios.com>
> Date:   Sat Mar 23 13:34:22 2013 -0400
>
>      Version 1.1.0
>
>      Signed-off-by: Mathieu Desnoyers<mathieu.desnoyers@efficios.com>

Mathieu,
We noticed this timely release and start to use babeltrace 1.1.0 in GDB. 
  GDB is able read ctf via babeltrace now, just fyi... and thanks for 
your help on some ctf explanations.


-- 
Yao (齐尧)
