# Plannerly
<br>
<h3 align ="center">Problem Statement </h3>
 <center>Task management can be overwhelming, often lacking a user-friendly and comprehensive solution. Users struggle with disorganized to-do lists, prioritization difficulties, and a lack of analytics to track their productivity. </center>

<h3 align ="center">Plannerly</h3>

<p align="center"> It is a user-friendly todo app designed to simplify task organization. Users can effortlessly add tasks, prioritize them as urgent or regular, and benefit from comprehensive analytics. Plannerly is the go-to productivity tool, offering an efficient solution for streamlined and effective task management.</p>

<p align="center">
  <img src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/6e0fcfbc-c9df-4bcb-a283-24c506a2734e" width=500px/><br>
  <img src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/5a20c786-c3ee-4469-aefe-6bee5cff112d" width=500px/><br>
  
</p>



<!--TABLE OF CONTENTS-->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a> 
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a> 
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
  </details>

  There are many great README templates available on GitHub;however, I didn't find one that really suited my needs so I created this one. I wanted to create a README template which satisfies the project.
  
Here's why:

- A project that solves a problem and helps others.
- One shouldn't be doing the same task over and over like creating a README from scratch.
- You should implement DRY principles to the rest of your life :smile:

Of course, no one template will serve all projects since your needs may be different. So i'll be  adding more in the near future.You may also suggest changes by forking this repo and creating a pull request or opening issue. Thanks to all the people have contributed to expanding this template!

<!--About the Project-->
  
## About The Project

LegalEdge is a flutter application which uses firebase to sign in users and create a new account. With the help of our Node.js backend we have integrated the functionalities of registering users, lawyers , creating posts , liking a post and also commenting on the posts. 
  

### Built With

This section should list any major frameworks/libraries used to bootstrap your project.Leave any add-ons/plugins for the acknowledgement section. Here are a few examples.

![image](https://user-images.githubusercontent.com/106571927/206698131-0921a8dc-5ea9-46f7-a68c-ad1c717a0ff1.png)

![image](https://user-images.githubusercontent.com/106571927/206698233-ac9c9c2b-0d7d-49b9-8995-1c0761329324.png)

<img height="100px" src="https://upload.wikimedia.org/wikipedia/commons/0/05/Go_Logo_Blue.svg"/>

<img height="200px" src="https://www.openlogic.com/sites/default/files/image/2021-06/image-blog-openlogic-what-is-mongodb.png"/>

<img height="200px" src="https://logos-world.net/wp-content/uploads/2021/02/Docker-Logo.png"/>





<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!--GETTING STARTED-->

## Getting Started

We recommend creating a new flutter project using 'flutter create --org project_name' ,
which sets up a default application setup automatically. To create a project, run the followingf command in cmd after downloading and sucessfully installing flutter:

'flutter create --org project_name'

### Prerequisites

After the installation is complete:

In the main file try running with the run without debugging:

![Screenshot (13)](https://user-images.githubusercontent.com/106571927/206700482-3ca687cf-49ef-40e8-b8e4-3f56503153c8.png)

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### Installation 

Below is an example of how you can instruct your audience on installing and setting up your app.This template doesn't rely on any external dependencies or services.

1.Clone the repo 

git clone https://github.com/Uttkarsh-raj/Plannerly


2.Install the packages 

flutter pub get


<p align="right">(<a href="#readme-top">back to top</a>)</p>


##### Setup backend
Setup the repo in your local system
```
git clone https://github.com/Uttkarsh-raj/Legal-Edge.git
```
Create a .env file in the Backend folder of the project and add the following
```
PORT=8000
MONGODB_URL="<Your_Mongodb_Url_Here>"
SECRET_KEY= "<Your_Secret_Key_Here>"
```
Run the following commands next
```
go run main.go
```
The server has started and ready to send and receive requests.
Next, head to the Frontend/Plannerly/lib/utils/server/server_constants.dart and add these changes
```
var baseUrl = "http://your_id_address_here:8000";
```
Now you are ready to run the project locally.

## Routes

### 1. User Routes

#### POST '/user/signup'
* Send {first_name,last_name,email,password,phone} as Request body
* Responds as {success:true,data:documentId}

#### POST '/user/login'
* Send {email,password} as Request body
* Responds with {success:true , data: UserObject}

### 2. Task Routes
#### POST '/addTask'
* Send { user_id,title,desc,time,date,status} as Request body
* Responds as {success:true, data:TaskObject}

#### PATCH '/update/:id'
* Send {first_name,last_name,email,password,phone,or any params you want to change} as Request body
* Responds as {success:true,data:documentId}

#### GET '/getTasks'
* Responds as {success:true, data:TaskObjects}

#### GET '/getTask/:id'
* Responds as {success:true, data:TaskObject}

#### GET '/tasks/urgent'
* Responds as {success:true, data:TaskObject}

#### GET '/tasks/regular'
* Responds as {success:true, data:TaskObject}

#### DELETE '/delete/:id'
* Responds as {success:true, data:TaskObject}

#### POST '/search'
* Send {search} as Request body
* Responds as {success:true, data:TaskObject}

<!--USAGE EXAMPLES-->

## Usage
1. **Adding Tasks:**
   - **Problem:** Users face challenges in organizing their tasks efficiently.
   - **Solution:** With Plannerly, users can easily add tasks, ensuring a clear and organized to-do list.

2. **Prioritization:**
   - **Problem:** Users struggle to prioritize tasks, leading to confusion.
   - **Solution:** Plannerly allows users to categorize tasks as urgent or regular, aiding in effective prioritization.

3. **Comprehensive Analytics:**
   - **Problem:** Lack of insights into task completion and productivity.
   - **Solution:** Plannerly provides comprehensive analytics, enabling users to track their productivity and make informed decisions.

### Screenshots:

## Login and Signup Screens:

<img width="300" src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/0295c193-9a2b-41eb-a776-01ddfc3288a1"></img>
<img width="300" src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/92660d62-88a6-46f5-8886-ffb321cdf72e"></img>

## Other ScreenShots: 
<img width="320" src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/08de4db6-060a-4aeb-891d-4352d372365c"></img>
<img width="320" src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/2b15102c-f44d-4f98-ac62-dcaa29388d4e"></img>
<img width="320" src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/8bfddc36-a11f-4a59-8e62-81807fd7b6de"></img>
<img width="320" src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/38a01988-6c2d-49eb-b32a-830112c8798e"></img>
<img width="320" src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/cf2290b9-c34b-4e36-839a-3cd1bfa4d6d2"></img>
<img width="320" src="https://github.com/Uttkarsh-raj/Plannerly/assets/106571927/5500403d-4f22-4f81-909f-243d1872b931"></img>


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->

## Roadmap

- [x] Add Changelog
- [x] Add back to top links
- [x] Add Additional Templates w/ Examples
- [ ] Add "components" document to easily copy & paste sections of the readme
- [ ] Multi-language Support
  - [ ] Hindi
  - [ ] English

  
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!--CONTRIBUTING-->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire ,and create.Any contributions you make are *greatly appreciated*.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## License


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->

## Contact
Uttkarsh Raj - https://github.com/Uttkarsh-raj <br>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments

Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

- [Choose an Open Source License](https://choosealicense.com)
- [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
- [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
- [Malven's Grid Cheatsheet](https://grid.malven.co/)
- [Img Shields](https://shields.io)
- [GitHub Pages](https://pages.github.com)
- [Font Awesome](https://fontawesome.com)
- [React Icons](https://react-icons.github.io/react-icons/search) 

<p align="right">(<a href="#readme-top">back to top</a>)</p>
