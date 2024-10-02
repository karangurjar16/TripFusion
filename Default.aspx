<%@ Page Title="Welcome to TripFusion" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TripFusion._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="bg-gray-100 py-8 px-4">
        <section class="text-center mb-12" aria-labelledby="welcomeTitle">
            <h1 id="welcomeTitle" class="text-4xl font-bold text-gray-800">Welcome to TripFusion</h1>
            <p class="mt-4 text-lg text-gray-600">Your journey starts here! Explore exciting trips and experiences tailored just for you.</p>
            <p class="mt-6">
                <a href="TravelerSection.aspx" class="bg-blue-500 text-white font-semibold py-2 px-4 rounded-lg shadow hover:bg-blue-600 transition duration-300">Explore Trips &raquo;</a>
            </p>
        </section>

        <div class="flex flex-wrap justify-center space-x-4 space-y-4">
            <section class="bg-white shadow-md rounded-lg p-6 w-full max-w-sm" aria-labelledby="discoverTitle">
                <h2 id="discoverTitle" class="text-2xl font-semibold text-gray-800">Discover New Destinations</h2>
                <p class="mt-2 text-gray-600">
                    TripFusion offers a variety of trips to breathtaking destinations. Find the perfect getaway for you and your friends or family!
                </p>
                <p class="mt-4">
                    <a class="bg-green-500 text-white font-semibold py-2 px-4 rounded-lg shadow hover:bg-green-600 transition duration-300" href="DestinationList.aspx">View Destinations &raquo;</a>
                </p>
            </section>

            <section class="bg-white shadow-md rounded-lg p-6 w-full max-w-sm" aria-labelledby="planTitle">
                <h2 id="planTitle" class="text-2xl font-semibold text-gray-800">Plan Your Adventure</h2>
                <p class="mt-2 text-gray-600">
                    Use our easy-to-navigate platform to plan your next adventure with just a few clicks.
                </p>
                <p class="mt-4">
                    <a class="bg-yellow-500 text-white font-semibold py-2 px-4 rounded-lg shadow hover:bg-yellow-600 transition duration-300" href="TripPlanning.aspx">Get Started &raquo;</a>
                </p>
            </section>

            <section class="bg-white shadow-md rounded-lg p-6 w-full max-w-sm" aria-labelledby="supportTitle">
                <h2 id="supportTitle" class="text-2xl font-semibold text-gray-800">Need Assistance?</h2>
                <p class="mt-2 text-gray-600">
                    Our support team is here to help you with any questions or concerns you might have about your trips.
                </p>
                <p class="mt-4">
                    <a class="bg-red-500 text-white font-semibold py-2 px-4 rounded-lg shadow hover:bg-red-600 transition duration-300" href="ContactUs.aspx">Contact Us &raquo;</a>
                </p>
            </section>
        </div>
    </main>

</asp:Content>
