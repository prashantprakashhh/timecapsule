-- Table to store user information
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,                   -- Auto-incrementing unique ID for each user
    full_name VARCHAR(255) NOT NULL,               -- User's full name
    email VARCHAR(255) UNIQUE NOT NULL,            -- User's email (unique)
    password VARCHAR(255) NOT NULL,                -- User's password
    profile_pic VARCHAR(255),                      -- Path or URL to user's profile picture
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- When the user was created
);

-- Table to store messages between users
CREATE TABLE messages (
    message_id SERIAL PRIMARY KEY,                 -- Auto-incrementing unique ID for each message
    sender_id INT NOT NULL,                        -- User who sent the message (Foreign Key)
    receiver_id INT NOT NULL,                      -- User who receives the message (Foreign Key)
    message_text TEXT,                             -- Message content
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- When the message was sent
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Table to store images shared in messages
CREATE TABLE message_images (
    image_id SERIAL PRIMARY KEY,
    message_id INT NOT NULL,
    image_data BYTEA NOT NULL,    -- for the actual binary image
    FOREIGN KEY (message_id) REFERENCES messages(message_id) ON DELETE CASCADE
);

-- Table to store memories uploaded by users
CREATE TABLE memories (
    memory_id SERIAL PRIMARY KEY,                  -- Auto-incrementing unique ID for each memory
    user_id INT NOT NULL,                          -- User who uploaded the memory (Foreign Key)
    memory_type VARCHAR(10) CHECK (memory_type IN ('image', 'video', 'text')) NOT NULL, -- Type of memory
    memory_content TEXT,                           -- Content (text if applicable)
    memory_url TEXT,                       -- URL/path to the memory (for images/videos)
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- When the memory was uploaded
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
